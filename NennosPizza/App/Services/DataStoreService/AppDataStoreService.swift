//
//  AppDataStoreService.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxSwift

class AppDataStoreService: DataStoreService {
    // MARK: - Types

    private struct PrivateConstants {
        static let cartPath = DataStoreValuePath(key: "CART", domain: DataStoreDomain.generalPersistent)
    }

    // MARK: - AppDataStoreServiceProtocol properties

    let cartPublisher = BehaviorSubject<Cart>(value: Cart())

    var cart: Cart {
        get {
            guard let value = cartData else {
                return Cart()
            }

            do {
                return try JSONDecoder().decode(Cart.self, from: value)
            } catch {
                return Cart()
            }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                cartData = data
                cartPublisher.onNext(newValue)
            }
        }
    }

    // MARK: - Properties

    private var cartData: Data? {
        get {
            return value(forPath: PrivateConstants.cartPath)
        }
        set {
            setValue(newValue, forPath: PrivateConstants.cartPath)
        }
    }

    // MARK: - DataStoreService initialization

    override init(dataStoreFactory: @escaping DataStoreFactory) {
        super.init(dataStoreFactory: dataStoreFactory)

        cartPublisher.onNext(cart)
    }
}

// MARK: - AppDataStoreServiceProtocol

extension AppDataStoreService: AppDataStoreServiceProtocol {
    func addPizzaToCart(_ pizza: Pizza) {
        var pizza = pizza
        pizza.cartId = UUID()
        cart.pizzas.append(pizza)
    }

    func removePizzaFromCart(_ pizza: Pizza) {
        cart.pizzas.removeAll(where: { $0 == pizza })
    }

    func addDrinkToCart(_ drink: Drink) {
        var drink = drink
        drink.cartId = UUID()
        cart.drinks.append(drink)
    }

    func removeDrinkFromCart(_ drink: Drink) {
        cart.drinks.removeAll(where: { $0 == drink })
    }

    func deleteCart() {
        cart = Cart()
    }
}
