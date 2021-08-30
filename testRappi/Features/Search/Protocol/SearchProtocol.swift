//
//  SearchProtocol.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 30/07/21.
//  
//

import Foundation
import UIKit
/// Protocolo que define los métodos y atributos para el view de Search
protocol SearchViewProtocol {
    // PRESENTER -> VIEW
    func showMovies(data: [MovieListDetail])
}
/// Protocolo que define los métodos y atributos para el routing de Search
protocol SearchRouterProtocol {
    // PRESENTER -> ROUTING
    func showDetail(movie: MovieListDetail)
}
/// Protocolo que define los métodos y atributos para el Presenter de Search
protocol SearchPresenterProtocol {
    // VIEW -> PRESENTER
    func getMoviesBy(query: String)
    func pressDetail(movie: MovieListDetail)
}
/// Protocolo que define los métodos y atributos para el Interactor de Search
protocol SearchInteractorInputProtocol {
    // PRESENTER -> INTERACTOR
    func fetchMoviesBy(query: String)
}
/// Protocolo que define los métodos y atributos para el Interactor de Search
protocol SearchInteractorOutputProtocol {
    // INTERACTOR -> PRESENTER
    func sendMovies(data: MovieListResponse)
}
