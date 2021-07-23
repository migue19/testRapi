//
//  HomeVC.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 20/07/21.
//

import UIKit
import WebKit
class HomeVC: UIViewController {
    var presenter: HomePresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    private func getData() {
        presenter?.getInformation()
    }
}
///Protocolo para recibir datos de presenter.
extension HomeVC: HomeViewProtocol {
}
