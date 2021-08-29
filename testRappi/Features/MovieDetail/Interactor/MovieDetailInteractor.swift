//
//  MovieDetailInteractor.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 29/08/21.
//  
//

import Foundation

class MovieDetailInteractor {
    var presenter: MovieDetailInteractorOutputProtocol?
}
extension MovieDetailInteractor: MovieDetailInteractorInputProtocol {
}
