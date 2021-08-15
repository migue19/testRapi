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
}
extension SearchPresenter: SearchInteractorOutputProtocol {
}
