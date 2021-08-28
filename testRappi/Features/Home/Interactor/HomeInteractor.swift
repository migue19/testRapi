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
        if Persistence.getInfoUserDefaults(key: "accessToken") != nil {
            getAllMovies()
        } else {
            getRequestToken()
        }
    }
    func getAllMovies() {
        DispatchQueue.global(qos: .userInitiated).async(group: dispatchGroup) { [weak self] in
            guard let self = self else {
                return
            }
            self.getMovieFor(type: .popular)
            self.getMovieFor(type: .topRated)
            self.getMovieFor(type: .upcoming)
            self.getMovieFor(type: .nowPlaying)
        }
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            self.movies.forEach { response in
                let error = response.error
                let movies = response.movies
                let section = response.section
                print(section, error.valueOrEmpty, movies ?? "")
            }
            self.receiveMovies(data: self.movies)
        }
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
                return
            }
            if let error = error {
                self.movies.append(MoviesResponseEntity(section: type, movies: nil, error: error))
                return
            }
            guard let data = data else {
                return
            }
            if let entity = self.decode(MovieListResponse.self, from: data, serviceName: "Popular Movie Service") {
                self.movies.append(MoviesResponseEntity(section: type, movies: entity, error: nil))
            }
            self.dispatchGroup.leave()
        }
    }
//    func getPopularMovie() {
//        let url = TypeMovieV3.popular.url
//        dispatchGroup.enter()
//        connectionLayer.conneccionRequest(url: url, method: .get, headers: [:], parameters: nil) { [weak self] (data, error) in
//            guard let self = self else {
//                return
//            }
//            if let error = error {
//                self.movies.append(MoviesResponseEntity(section: .popular, movies: nil, error: error))
//                return
//            }
//            guard let data = data else {
//                return
//            }
//            if let entity = self.decode(MovieListResponse.self, from: data, serviceName: "Popular Movie Service") {
//                self.movies.append(MoviesResponseEntity(section: .popular, movies: entity, error: nil))
//            }
//            self.dispatchGroup.leave()
//        }
//    }
//    func getTopRatedMovie() {
//        let url = TypeMovieV3.topRated.url
//        self.dispatchGroup.enter()
//        connectionLayer.conneccionRequest(url: url, method: .get, headers: [:], parameters: nil) { [weak self] (data, error) in
//            guard let self = self else {
//                return
//            }
//            if let error = error {
//                self.movies.append(MoviesResponseEntity(section: .topRated, movies: nil, error: error))
//                return
//            }
//            guard let data = data else {
//                return
//            }
//            if let entity = self.decode(MovieListResponse.self, from: data, serviceName: "Popular Movie Service") {
//                self.movies.append(MoviesResponseEntity(section: .topRated, movies: entity, error: nil))
//            }
//            self.dispatchGroup.leave()
//        }
//    }
    func receiveMovies(data: [MoviesResponseEntity]) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.sendMovies(data: data)
        }
    }
    func decode<T: Codable>(_ type: T.Type, from data: Data, serviceName: String) -> T? {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print("DecodingError in \(serviceName) - Context:", context.codingPath)
        } catch let DecodingError.keyNotFound(key, context) {
            print("DecodingError in \(serviceName) - Key '\(key)' not found:", context.debugDescription)
            print("DecodingError in \(serviceName) - CodingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("DecodingError in \(serviceName) - Value '\(value)' not found:", context.debugDescription)
            print("DecodingError in \(serviceName) - CodingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context) {
            print("DecodingError in \(serviceName) - Type '\(type)' mismatch:", context.debugDescription)
            print("DecodingError in \(serviceName) - CodingPath:", context.codingPath)
        } catch {
            print("DecodingError in \(serviceName) - Error: ", error)
        }
        return nil
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
                print(error)
            }
            guard let data = data else {
                return
            }
            if let accountListResponse = self.decode(AccountListResponse.self, from: data, serviceName: "AccountListService") {
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
            if let requestToken = self.decode(RequestTokenResponse.self, from: data, serviceName: "Request Token") {
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
            if let accessTokenResponse = self.decode(AccessTokenResponse.self, from: data, serviceName: "AccessTokenService") {
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
