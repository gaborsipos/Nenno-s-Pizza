//
//  UIColor+Exts.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        var cleanHexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if cleanHexString.hasPrefix("#") {
            cleanHexString.remove(at: cleanHexString.startIndex)
        }

        guard cleanHexString.count == 6 else {
            self.init(red: 1, green: 1, blue: 1, alpha: 1)
            return
        }

        var rgb = UInt64()
        Scanner(string: cleanHexString).scanHexInt64(&rgb)

        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1
        )
    }
}
