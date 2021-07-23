//
//  HomePresenter.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 20/07/21.
//  
//

import Foundation

class HomePresenter {
    var view: HomeViewProtocol?
    var interactor: HomeInteractorInputProtocol?
    var router: HomeRouterProtocol?
}
extension HomePresenter: HomePresenterProtocol {
    func getInformation() {
        interactor?.getMovies()
    }
    
}
extension HomePresenter: HomeInteractorOutputProtocol {
    func sendRequestToken(token: String) {
        let urlString = MovieDBURL.urlWeb.replacingOccurrences(of: "{request_token}", with: token)
        guard let url: URL = URL(string: urlString) else {
            return
        }
        router?.showApproveToken(url: url, token: token)
    }
}
