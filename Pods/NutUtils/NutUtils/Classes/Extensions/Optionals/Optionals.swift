//
//  Optionals.swift
//  NutUtils
//
//  Created by Miguel Mexicano Herrera on 21/07/21.
//

import Foundation
public extension Optional where Wrapped == String {
    /// Garantiza el retorno de un String, si es opcional será una cadena vacía.
    var valueOrEmpty: String {
        guard let unwrapped = self else {
            return ""
        }
        return unwrapped
    }
}
public extension Optional where Wrapped == Data {
    /// Garantiza el retorno de una Data, si es opcional será una Data vacía.
    var valueOrEmpty: Wrapped {
        guard let unwrapped = self else {
            return Data()
        }
        return unwrapped
    }
}
public extension Optional where Wrapped == Int {
    /// Garantiza el retorno de un Int, si es opcional será entero 0.
    var valueOrZero: Int {
        guard let unwrapped = self else {
            return 0
        }
        return unwrapped
    }
}
public extension Optional where Wrapped == Date {
    /// Garantiza el retorno de una Date, si es opcional será la fecha de hoy.
    var valueOrCurrent: Date {
        guard let unwrapped = self else {
            return Date()
        }
        return unwrapped
    }
}
