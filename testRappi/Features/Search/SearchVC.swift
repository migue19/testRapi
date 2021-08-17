//
//  SearchVC.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 30/07/21.
//  
//

import Foundation
import UIKit

class SearchVC: UIViewController {

    var presenter: SearchPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
/// Protocolo para recibir datos de presenter.
extension SearchVC: SearchViewProtocol {
}
