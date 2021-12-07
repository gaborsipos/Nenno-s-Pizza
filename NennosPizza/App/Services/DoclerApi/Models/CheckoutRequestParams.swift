//
//  CheckoutRequest.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 07..
//

struct CheckoutRequestParams: Encodable {
    // MARK: - Properties

    let pizzas: [DoclerApiService.Pizza]
    let drinks: [DoclerApiService.Drink]
}
