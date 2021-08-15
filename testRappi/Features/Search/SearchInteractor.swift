//
//  SearchInteractor.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 30/07/21.
//  
//

import Foundation

class SearchInteractor {
    var presenter: SearchInteractorOutputProtocol?
}
extension SearchInteractor: SearchInteractorInputProtocol {
}
