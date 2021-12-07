//
//  CartCellModel.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

struct CartCellModel {
    let imageName: String?
    let title: String
    let price: Double
    let tap: (() -> Void)?

    init(imageName: String? = nil, title: String, price: Double, tap: (() -> Void)? = nil) {
        self.imageName = imageName
        self.title = title
        self.price = price
        self.tap = tap
    }
}
