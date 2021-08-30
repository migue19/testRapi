//
//  UIViewController.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 29/08/21.
//

import UIKit

extension UIViewController {
    /// Propiedad para detectar si se cuenta con modo obscuro.
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return self.traitCollection.userInterfaceStyle == .dark
        } else {
            return false
        }
    }
    /// Función utilizada para pintar la imagen adecuada cuando para realizar la acción de volver.
    func setCloseNavigationItem() {
        var btnBack: UIBarButtonItem?
        if self.navigationController?.viewControllers.count == 1 {
            btnBack = UIBarButtonItem(image: UIImage(named: "icon_close"), style: .done, target: self, action: #selector(self.dismiss(_:)))
        } else {
            btnBack = UIBarButtonItem(image: UIImage(named: "icon_back"), style: .done, target: self, action: #selector(self.popViewController(_:)))
        }
        self.navigationItem.leftBarButtonItem = btnBack
    }
    /// Función que agrega botón de cerrar en caso de que sólo exista un controlador en el navigationController
    /// - Parameter image: Imagen del botón
    func addCloseButtonInNavigationController(image: String = "icon_close") {
        if self.navigationController?.viewControllers.count == 1 {
            let btnBack = UIBarButtonItem(image: UIImage(named: image), style: .done, target: self, action: #selector(self.dismiss(_:)))
            self.navigationItem.leftBarButtonItem = btnBack
        }
    }
    @objc private func dismiss(_ action: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func popViewController(_ action: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}
