//
//  MovieDetailVC.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 29/08/21.
//

import UIKit

class MovieDetailVC: UIViewController {
    var presenter: MovieDetailPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
/// Protocolo para recibir datos de presenter.
extension MovieDetailVC: MovieDetailViewProtocol {
}
