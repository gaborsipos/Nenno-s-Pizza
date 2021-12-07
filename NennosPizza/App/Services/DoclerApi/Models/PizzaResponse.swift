//
//  PizzaResponse.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

struct PizzaResponse: Decodable {
    // MARK: - Properties

    let basePrice: Double
    let pizzas: [DoclerApiService.Pizza]
}
