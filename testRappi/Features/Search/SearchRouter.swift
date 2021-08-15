//
//  SearchRouter.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 30/07/21.
//  
//

import Foundation
import UIKit

class SearchRouter {
    private var view: SearchVC
    private var presenter: SearchPresenter
    private var interactor: SearchInteractor
    private var window: UIWindow?
    init(in window: UIWindow?) {
        self.view = SearchVC()
        self.presenter = SearchPresenter()
        self.interactor = SearchInteractor()
        view.presenter = self.presenter
        presenter.view = self.view
        presenter.interactor = self.interactor
        presenter.router = self
        interactor.presenter = self.presenter
        self.window = window
    }
    func showView() {
        window?.rootViewController = UINavigationController(rootViewController: view)
        window?.makeKeyAndVisible()
    }
}
extension SearchRouter: SearchRouterProtocol {
}

