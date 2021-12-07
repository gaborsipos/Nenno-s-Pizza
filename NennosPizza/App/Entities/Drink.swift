//
//  Drink.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 07..
//

import Foundation

struct Drink: Codable, Equatable {
    // MARK: - Properties

    var cartId: UUID?
    let id: Int
    let name: String
    let price: Double
}
