//
//  UIView+Exts.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 07..
//

import UIKit

extension UIView {
    public static func scaledHeight(fromContentWidth contentWidth: CGFloat, designedWidth: CGFloat, designedHeight: CGFloat) -> CGFloat {
        let scale: CGFloat = contentWidth / designedWidth
        let height = designedHeight * scale

        return height
    }
}
