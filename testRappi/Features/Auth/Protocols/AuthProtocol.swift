//
//  AuthProtocol.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 15/08/21.
//

import Foundation
protocol AuthApproveTokenDelegate: AnyObject {
    func approveSuccess(token: String)
}
