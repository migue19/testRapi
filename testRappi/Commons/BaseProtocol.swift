//
//  BaseProtocol.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 17/08/21.
//

import Foundation
/// Protocolo general para las vistas.
protocol GeneralView {
    /// Función para mostrar un mensaje en una alerta.
    /// - Parameter message: Cadena con el mensaje a mostrarse en la alerta.
    func showMessage(message: String)
}
extension GeneralView {
    func showMessage(message: String) {
    }
}
