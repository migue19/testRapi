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
    func pressDetail(movie: MovieListDetail) {
        router?.showDetail(movie: movie)
    }
    func getInformation() {
        view?.showHUD()
        interactor?.getMovies()
    }
}
extension HomePresenter: HomeInteractorOutputProtocol {
    func sendErrorMessage(message: String) {
        view?.hideHUD()
        view?.showMessage(message: message, type: .error)
    }
    func sendMovies(data: [MoviesResponseEntity]) {
        view?.hideHUD()
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
