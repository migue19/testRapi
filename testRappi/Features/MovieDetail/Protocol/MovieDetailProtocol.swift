//
//  MovieDetailProtocol.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 29/08/21.
//  
//

import Foundation
import UIKit
/// Protocolo que define los métodos y atributos para el view de MovieDetail
protocol MovieDetailViewProtocol {
    // PRESENTER -> VIEW
    func showVideos(data: [VideoListDetail])
}
/// Protocolo que define los métodos y atributos para el routing de MovieDetail
protocol MovieDetailRouterProtocol {
    // PRESENTER -> ROUTING
}
/// Protocolo que define los métodos y atributos para el Presenter de MovieDetail
protocol MovieDetailPresenterProtocol {
    // VIEW -> PRESENTER
    func getVideos()
}
/// Protocolo que define los métodos y atributos para el Interactor de MovieDetail
protocol MovieDetailInteractorInputProtocol {
    // PRESENTER -> INTERACTOR
    func fetchVideos()
}
/// Protocolo que define los métodos y atributos para el Interactor de MovieDetail
protocol MovieDetailInteractorOutputProtocol {
    // INTERACTOR -> PRESENTER
    func sendVideos(data: VideoList)
}
