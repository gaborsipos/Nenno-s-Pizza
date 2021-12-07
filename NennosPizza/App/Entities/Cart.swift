//
//  Cart.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

struct Cart: Codable {
    // MARK: - Properties

    var pizzas: [Pizza] = []
    var drinks: [Drink] = []

    var price: Double {
        var price: Double = 0

        price += pizzas.map({ $0.price }).reduce(0, +)
        price += drinks.map({ $0.price }).reduce(0, +)

        return price
    }

    var isEmpty: Bool {
        pizzas.count == 0 && drinks.count == 0
    }
}
