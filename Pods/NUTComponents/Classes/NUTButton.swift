//
//  NUTButton.swift
//  NUTComponents
//
//  Created by Miguel Mexicano Herrera on 31/10/20.
//

import Foundation
import UIKit
extension UIButton {
    @IBInspectable var normalBorder: Bool{
        get{
            return self.normalBorder
        }
        set (hasDone) {
            if hasDone{
                layer.cornerRadius = layer.frame.height/2
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}
