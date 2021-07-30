//
//  UIView.swift
//  NutUtils
//
//  Created by Miguel Mexicano Herrera on 30/07/21.
//

import UIKit
extension UIView {
    public func elevate(elevation: Double, shadowColor: CGColor = UIColor.black.cgColor) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor
        self.layer.shadowOffset = CGSize(width: 0, height: elevation)
        self.layer.shadowRadius = CGFloat(elevation)
        self.layer.shadowOpacity = 0.5
    }
}
