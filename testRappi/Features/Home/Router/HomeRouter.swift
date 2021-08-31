//
//  HomeRouter.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 20/07/21.
//  
//

import Foundation
import UIKit

class HomeRouter {
    var view: HomeVC
    private var presenter: HomePresenter
    private var interactor: HomeInteractor
    init() {
        self.view = HomeVC()
        self.presenter = HomePresenter()
        self.interactor = HomeInteractor()
        view.presenter = self.presenter
        presenter.view = self.view
        presenter.interactor = self.interactor
        presenter.router = self
        interactor.presenter = self.presenter
    }
}
extension HomeRouter: HomeRouterProtocol {
    func showDetail(movie: MovieListDetail) {
        let detail = MovieDetailRouter(data: movie)
        let navigationController = UINavigationController(rootViewController: detail.view)
        navigationController.modalPresentationStyle = .fullScreen
        view.present(navigationController, animated: true, completion: nil)
    }
}
