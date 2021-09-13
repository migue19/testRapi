//
//  HomeInteractor.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 20/07/21.
//  
//

import Foundation
import ConnectionLayer
class HomeInteractor {
    var presenter: HomeInteractorOutputProtocol?
    var connectionLayer = ConnectionLayer(isDebug: false)
    let dispatchGroup = DispatchGroup()
    var movies: [MoviesResponseEntity] = []
}
extension HomeInteractor: HomeInteractorInputProtocol {
    func getMovies() {
        getAllMovies()
    }
    func getAllMovies() {
        DispatchQueue.global(qos: .userInitiated).async(group: dispatchGroup) { [weak self] in
            guard let self = self else {
                return
            }
            TypeMovieV3.allCases.forEach { [weak self] type in
                self?.getMovieFor(type: type)
            }
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            self.receiveMovies(data: self.movies)
        }
    }
    func receiveMovies(data: [MoviesResponseEntity]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            let movies = self.sortedMovies(data: data)
            self.presenter?.sendMovies(data: movies)
        }
    }
    private func sortedMovies(data: [MoviesResponseEntity]) -> [MoviesResponseEntity] {
        let movies = data.sorted(by: { $0.section.title < $1.section.title })
        return movies
    }
    func getMovieFor(type: TypeMovieV3) {
        let url = type.url
        dispatchGroup.enter()
        connectionLayer.connectionRequest(url: url, method: .get) { [weak self] (data, error) in
            guard let self = self else {
                debugPrint("self_not_found".localized)
                return
            }
            if let error = error {
                self.receiveError(message: error)
                self.movies.append(MoviesResponseEntity(section: type, movies: nil, error: error))
                self.dispatchGroup.leave()
                return
            }
            guard let data = data else {
                let error = "data_not_found".localized
                self.receiveError(message: error)
                self.movies.append(MoviesResponseEntity(section: type, movies: nil, error: error))
                self.dispatchGroup.leave()
                return
            }
            if let entity = Utils.decode(MovieListResponse.self, from: data, serviceName: "\(type.title) \("movie_service".localized)") {
                self.movies.append(MoviesResponseEntity(section: type, movies: entity, error: nil))
            } else {
                let error = "decode_error".localized
                self.receiveError(message: error)
                self.movies.append(MoviesResponseEntity(section: type, movies: nil, error: error))
            }
            self.dispatchGroup.leave()
        }
    }
    func getMovie(url: String, token: String) {
        let headers: HTTPHeaders = HTTPHeaders([
            HTTPHeaders.authorization(bearerToken: token),
            HTTPHeaders.contentTypeJson,
            HTTPHeaders.acceptJson
        ])
        let accountId = Persistence.getInfoUserDefaults(key: "accountId")
        let url = url.replacingOccurrences(of: "{account_id}", with: accountId.valueOrEmpty)
        connectionLayer.connectionRequest(url: url, method: .get, headers: headers) { [weak self] (data, error) in
            guard let self = self else {
                return
            }
            if let error = error {
                self.receiveError(message: error)
            }
            guard let data = data else {
                return
            }
            if let accountListResponse = Utils.decode(AccountListResponse.self, from: data, serviceName: "AccountListService") {
                print(accountListResponse)
            }
        }
    }
    func receiveError(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.sendErrorMessage(message: message)
        }
    }
}
