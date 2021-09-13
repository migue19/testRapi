//
//  SearchInteractor.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 30/07/21.
//  
//

import Foundation
import ConnectionLayer
class SearchInteractor {
    var presenter: SearchInteractorOutputProtocol?
    var connectionLayer = ConnectionLayer(isDebug: false)
}
extension SearchInteractor: SearchInteractorInputProtocol {
    func fetchMoviesBy(query: String) {
        let url = SearchType.search.url + query
        connectionLayer.connectionRequest(url: url, method: .get) { [weak self] (data, error) in
            guard let self = self else {
                debugPrint("self_not_found".localized)
                return
            }
            if let error = error {
                self.receiveError(message: error)
                return
            }
            guard let data = data else {
                let error = "data_not_found".localized
                self.receiveError(message: error)
                return
            }
            if let entity = Utils.decode(MovieListResponse.self, from: data, serviceName: "Search Movie Service") {
                self.receiveMovies(data: entity)
            } else {
                let error = "decode_error".localized
                self.receiveError(message: error)
            }
        }
    }
    func receiveMovies(data: MovieListResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.sendMovies(data: data)
        }
    }
    func receiveError(message: String) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.sendErrorMessage(message: message)
        }
    }
}
