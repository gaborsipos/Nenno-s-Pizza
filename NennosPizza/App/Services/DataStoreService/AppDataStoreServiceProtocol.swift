//
//  AppDataStoreServiceProtocol.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxSwift

protocol AppDataStoreServiceProtocol: DataStoreServiceProtocol {
    var cartPublisher: BehaviorSubject<Cart> { get }
    var cart: Cart { get }

    func addPizzaToCart(_ pizza: Pizza)
    func removePizzaFromCart(_ pizza: Pizza)
    func addDrinkToCart(_ drink: Drink)
    func removeDrinkFromCart(_ drink: Drink)
    func deleteCart()
}
