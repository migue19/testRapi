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
}
extension HomeInteractor: HomeInteractorInputProtocol {
    func getMovies() {
        if let token = Persistence.getInfoUserDefaults(key: "accessToken") {
            // getList(type: .list, token: token)
            // getList(type: .favoriteMovies, token: token)
            // getList(type: .movieRecommendations, token: token)
            // getList(type: .movieWatchlist, token: token)
            // getList(type: .movieRated, token: token)
            print(token)
            getMovieV3()
        } else {
            getRequestToken()
        }
    }
    func getList(type: AccountService, token: String) {
        let url = type.url
        getMovie(url: url, token: token)
    }
    func getMovieV3() {
        let url = TMDb.ApiV3.moviePopular
        connectionLayer.conneccionRequest(url: url, method: .get, headers: [:], parameters: nil) { (data, error) in
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
            if let entity = self.decode(MovieListResponse.self, from: data, serviceName: "Popular Movie Service") {
                self.receivePopularMovies(data: entity)
            }
        }
    }
    func receivePopularMovies(data: MovieListResponse) {
        DispatchQueue.main.async {
            self.presenter?.sendPopularMovies(data: data)
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
        connectionLayer.conneccionRequest(url: url, method: .get, headers: headers, parameters: nil) { (data, error) in
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
        connectionLayer.conneccionRequest(url: url, method: .post, headers: headers, parameters: nil) { (data, error) in
            if let error = error {
                print(error)
            }
            guard let data = data else {
                return
            }
            if let requestToken = self.decode(RequestTokenResponse.self, from: data, serviceName: "kdkdkl") {
                self.receiveData(entity: requestToken)
            }
        }
    }
    func receiveData(entity: RequestTokenResponse) {
        DispatchQueue.main.async {
            self.presenter?.sendRequestToken(token: entity.token)
        }
    }
    func receiveError(message: String) {
        DispatchQueue.main.async {
            print(message)
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
        connectionLayer.conneccionRequest(url: url, method: .post, headers: headers, parameters: body) { (data, error) in
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
