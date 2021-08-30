//
//  SearchPresenter.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 30/07/21.
//  
//

import Foundation

class SearchPresenter {
    var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
}
extension SearchPresenter: SearchPresenterProtocol {
    func pressDetail(movie: MovieListDetail) {
        router?.showDetail(movie: movie)
    }
    func getMoviesBy(query: String) {
        interactor?.fetchMoviesBy(query: query)
    }
}
extension SearchPresenter: SearchInteractorOutputProtocol {
    func sendErrorMessage(message: String) {
        view?.showMessage(message: message, type: .error)
    }
    func sendMovies(data: MovieListResponse) {
        view?.showMovies(data: data.results)
    }
}
