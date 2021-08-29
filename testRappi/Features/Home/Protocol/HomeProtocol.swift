//
//  HomeProtocol.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 20/07/21.
//  
//

import Foundation
import UIKit
/// Protocolo que define los métodos y atributos para el view de Home
/// PRESENTER -> VIEW
protocol HomeViewProtocol: GeneralView {
    func showMovies(data: [MoviesResponseEntity])
}
/// Protocolo que define los métodos y atributos para el routing de Home
/// PRESENTER -> ROUTING
protocol HomeRouterProtocol {
    func showApproveToken(url: URL, token: String)
    func showDetail(movie: MovieListDetail)
}
/// Protocolo que define los métodos y atributos para el Presenter de Home
/// VIEW -> PRESENTER
protocol HomePresenterProtocol {
    func getInformation()
    func pressDetail(movie: MovieListDetail)
}
/// Protocolo que define los métodos y atributos para el Interactor de Home
/// PRESENTER -> INTERACTOR
protocol HomeInteractorInputProtocol {
    func getMovies()
}
/// Protocolo que define los métodos y atributos para el Interactor de Home
/// INTERACTOR -> PRESENTER
protocol HomeInteractorOutputProtocol {
    func sendRequestToken(token: String)
    func sendMovies(data: [MoviesResponseEntity])
    func sendErrorMessage(message: String)
}
protocol GroupMovieDelegate: AnyObject {
    func selectedMovie(movie: MovieListDetail)
}
