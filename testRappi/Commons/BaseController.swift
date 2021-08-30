//
//  BaseController.swift
//  testRappi
//
//  Created by Miguel Mexicano Herrera on 30/08/21.
//

import UIKit
class BaseController: UIViewController {
    var progress: ProgressViewCustom?
    override func viewDidLoad() {
        progress = ProgressViewCustom(inView: self.view)
    }
    func showHUD() {
        progress?.startProgressView()
    }
    func hideHUD() {
        progress?.stopProgressView()
    }
}
