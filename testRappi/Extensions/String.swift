//
//  String.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 19/08/21.
//

import Foundation
extension String {
    /// Función que encapsula la llamada al archivo strings del proyecto.
    ///     - Returns: Regresa el texto correcto del archivo strings o el mismo.
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
