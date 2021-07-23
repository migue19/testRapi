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
            getMovieRated(token: token)
            getAccountList(token: token)
        } else {
            getRequestToken()
        }
    }
    func getMovieRated(token: String) {
        let headers = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let accountId = Persistence.getInfoUserDefaults(key: "accountId")
        let url = MovieDBURL.movieRated.replacingOccurrences(of: "{account_id}", with: accountId.valueOrEmpty)
        connectionLayer.conneccionRequest(url: url, method: .get, headers: headers, parameters: nil) { (data, error) in
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            do {
                let accountListResponse = try decoder.decode(AccountListResponse.self, from: data)
                print(accountListResponse)
            } catch {
                self.receiveError(message: error.localizedDescription)
            }
        }
    }
    func getAccountList(token: String) {
        let headers = [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let accountId = Persistence.getInfoUserDefaults(key: "accountId")
        let url = MovieDBURL.accountList.replacingOccurrences(of: "{account_id}", with: accountId.valueOrEmpty)
        connectionLayer.conneccionRequest(url: url, method: .get, headers: headers, parameters: nil) { (data, error) in
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            do {
                let accountListResponse = try decoder.decode(AccountListResponse.self, from: data)
                print(accountListResponse)
            } catch {
                self.receiveError(message: error.localizedDescription)
            }
        }
    }
    func getRequestToken() {
        let headers = ["Authorization": "Bearer \(MovieDBURL.readAccessToken)"]
        connectionLayer.conneccionRequest(url: MovieDBURL.requestToken, method: .post, headers: headers, parameters: nil) { (data, error) in
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            do {
                let requestToken = try decoder.decode(RequestTokenResponse.self, from: data)
                self.receiveData(entity: requestToken)
            } catch {
                self.receiveError(message: error.localizedDescription)
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
            "Authorization": "Bearer \(MovieDBURL.readAccessToken)",
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        let body = ["request_token": token]
        connectionLayer.conneccionRequest(url: MovieDBURL.accessToken, method: .post, headers: headers, parameters: body) { (data, error) in
            guard let data = data else {
                return
            }
            let decoder = JSONDecoder()
            do {
                let accessTokenResponse = try decoder.decode(AccessTokenResponse.self, from: data)
                self.saveAccessToken(accessTokenResponse: accessTokenResponse)
            } catch {
                self.receiveError(message: error.localizedDescription)
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
