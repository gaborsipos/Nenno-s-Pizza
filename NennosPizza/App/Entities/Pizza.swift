//
//  Pizza.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 07..
//

import Foundation

struct Pizza: Codable, Equatable {
    // MARK: - Types

    struct Ingredient: Codable, Equatable {
        let id: Int
        let name: String
        let price: Double
        var isAdded: Bool
    }

    // MARK: - Properties

    var cartId: UUID?
    let name: String
    let basePrice: Double
    var ingredients: [Ingredient]
    let imageUrl: String?

    var addedIngredients: [Ingredient] {
        ingredients.filter({ $0.isAdded })
    }

    var price: Double {
        var price = basePrice

        price += addedIngredients.map({ $0.price }).reduce(0, +)

        return price
    }
}
