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
        view.present(navigationController, animated: true, completion: nil)
    }
    func showApproveToken(url: URL, token: String) {
        let auth = AuthVC(url: url, token: token)
        auth.delegate = self
        view.present(auth, animated: true, completion: nil)
    }
}
extension HomeRouter: AuthApproveTokenDelegate {
    func approveSuccess(token: String) {
        interactor.requestAccessToken(token: token)
    }
}
