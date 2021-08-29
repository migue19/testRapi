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
    func sendErrorMessage(message: String) {
        view?.showMessage(message: message)
    }
    func sendMovies(data: [MoviesResponseEntity]) {
        view?.showMovies(data: data)
    }
    func sendRequestToken(token: String) {
        let urlString = TMDb.urlWeb.replacingOccurrences(of: "{request_token}", with: token)
        guard let url: URL = URL(string: urlString) else {
            return
        }
        router?.showApproveToken(url: url, token: token)
    }
}
