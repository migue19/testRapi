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
    var connectionLayer = ConnectionLayer()
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
    func getList(type: AccountService, token: String) {
        let url = type.url
        getMovie(url: url, token: token)
    }
    func getMovieFor(type: TypeMovieV3) {
        let url = type.url
        dispatchGroup.enter()
        connectionLayer.conneccionRequest(url: url, method: .get, headers: [:], parameters: nil) { [weak self] (data, error) in
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
        let headers = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let accountId = Persistence.getInfoUserDefaults(key: "accountId")
        let url = url.replacingOccurrences(of: "{account_id}", with: accountId.valueOrEmpty)
        connectionLayer.conneccionRequest(url: url, method: .get, headers: headers, parameters: nil) { [weak self] (data, error) in
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
    func getRequestToken() {
        let headers = ["Authorization": "Bearer \(TMDb.readAccessToken)"]
        let url = TMDb.ApiV4.requestToken
        connectionLayer.conneccionRequest(url: url, method: .post, headers: headers, parameters: nil) { [weak self] (data, error) in
            guard let self = self else {
                return
            }
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
            if let requestToken = Utils.decode(RequestTokenResponse.self, from: data, serviceName: "Request Token") {
                self.receiveData(entity: requestToken)
            }
        }
    }
    func receiveData(entity: RequestTokenResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.sendRequestToken(token: entity.token)
        }
    }
    func receiveError(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.sendErrorMessage(message: message)
        }
    }
    func requestAccessToken(token: String) {
        let headers = [
            "Authorization": "Bearer \(TMDb.readAccessToken)",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let body = ["request_token": token]
        let url = TMDb.ApiV4.accessToken
        connectionLayer.conneccionRequest(url: url, method: .post, headers: headers, parameters: body) { [weak self] (data, error) in
            guard let self = self else {
                return
            }
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
            if let accessTokenResponse = Utils.decode(AccessTokenResponse.self, from: data, serviceName: "AccessTokenService") {
                self.saveAccessToken(accessTokenResponse: accessTokenResponse)
            }
        }
    }
    func saveAccessToken(accessTokenResponse: AccessTokenResponse) {
        let token = accessTokenResponse.token
        let accountId = accessTokenResponse.accountId
        Persistence.saveInfoUserDefaults(key: "accountId", value: accountId)
        Persistence.saveInfoUserDefaults(key: "accessToken", value: token)
    }
}
