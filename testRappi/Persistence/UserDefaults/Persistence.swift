//
//  Persistence.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 21/07/21.
//

import Foundation
class Persistence {
    static func saveInfoUserDefaults(key: String, value: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    static func getInfoUserDefaults(key: String) -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key)
    }
    static func deleteInfoUserDefaults(key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
}
