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
protocol HomeViewProtocol {
    // PRESENTER -> VIEW
    func showPopularMovies(data: MovieListResponse)
}
/// Protocolo que define los métodos y atributos para el routing de Home
protocol HomeRouterProtocol {
    // PRESENTER -> ROUTING
    func showApproveToken(url: URL, token: String)
}
/// Protocolo que define los métodos y atributos para el Presenter de Home
protocol HomePresenterProtocol {
    // VIEW -> PRESENTER
    func getInformation()
}
/// Protocolo que define los métodos y atributos para el Interactor de Home
protocol HomeInteractorInputProtocol {
    // PRESENTER -> INTERACTOR
    func getMovies()
}
/// Protocolo que define los métodos y atributos para el Interactor de Home
protocol HomeInteractorOutputProtocol {
    // INTERACTOR -> PRESENTER
    func sendRequestToken(token: String)
    func sendPopularMovies(data: MovieListResponse)
}
