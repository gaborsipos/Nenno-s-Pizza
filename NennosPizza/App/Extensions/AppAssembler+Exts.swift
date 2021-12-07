//
//  AppAssembler+Exts.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import Swinject

extension Assembler {
    func resolveAppDataStoreService() -> AppDataStoreServiceProtocol {
        resolver.resolve(AppDataStoreServiceProtocol.self)!
    }

    func resolveDoclerApiService() -> DoclerApiServiceProtocol {
        resolver.resolve(DoclerApiServiceProtocol.self)!
    }

    func resolveHomeViewController() -> HomeViewControllerProtocol {
        resolver.resolve(HomeViewControllerProtocol.self)!
    }

    func resolvePizzaCreatorViewController(pizza: Pizza?) -> PizzaCreatorViewControllerProtocol {
        resolver.resolve(PizzaCreatorViewControllerProtocol.self, argument: pizza)!
    }

    func resolveCartViewController() -> CartViewControllerProtocol {
        resolver.resolve(CartViewControllerProtocol.self)!
    }

    func resolveDrinksViewController() -> DrinksViewControllerProtocol {
        resolver.resolve(DrinksViewControllerProtocol.self)!
    }

    func resolveCheckoutSuccessViewController() -> CheckoutSuccessViewControllerProtocol {
        resolver.resolve(CheckoutSuccessViewControllerProtocol.self)!
    }
}
