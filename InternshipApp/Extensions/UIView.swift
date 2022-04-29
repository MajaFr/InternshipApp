//
//  UIView.swift
//  InternshipApp
//
//  Created by Maja Frąk on 29/04/2022.
//

import UIKit

extension UIView {

    @IBInspectable public var cornerRadiusRatio: CGFloat {
        get {
            return layer.cornerRadius / frame.height
        }

        set {
            let normalizedRatio = max(0.0, min(1.0, newValue))
            layer.cornerRadius = frame.height * normalizedRatio
        }
    }
}
