//
//  MovieDetailRouter.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 29/08/21.
//  
//

import Foundation
import UIKit

class MovieDetailRouter {
    var view: MovieDetailVC
    private var presenter: MovieDetailPresenter
    private var interactor: MovieDetailInteractor
    init() {
        self.view = MovieDetailVC()
        self.presenter = MovieDetailPresenter()
        self.interactor = MovieDetailInteractor()
        view.presenter = self.presenter
        presenter.view = self.view
        presenter.interactor = self.interactor
        presenter.router = self
        interactor.presenter = self.presenter
    }
}
extension MovieDetailRouter: MovieDetailRouterProtocol {
}
