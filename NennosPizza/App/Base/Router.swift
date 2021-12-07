//
//  Router.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 07..
//

import UIKit

protocol Router {
    func popToRoot()
    func openCart()
    func openDrinks()
    func openCheckoutSuccess()
    func openPizzaCreator(pizza: Pizza?)
}

extension Router where Self: RootViewController {
    func popToRoot() {
        navigationController?.popToRootViewController(animated: true)
    }

    func openCart() {
        let cartVC = coreAssembler.resolveCartViewController()
        navigationController?.pushViewController(cartVC.viewController, animated: true)
    }

    func openDrinks() {
        let drinksVC = coreAssembler.resolveDrinksViewController()
        navigationController?.pushViewController(drinksVC.viewController, animated: true)
    }

    func openCheckoutSuccess() {
        var checkoutSuccessVC = coreAssembler.resolveCheckoutSuccessViewController()
        checkoutSuccessVC.isNavigationBarEnabled = false
        navigationController?.pushViewController(checkoutSuccessVC.viewController, animated: true)
    }

    func openPizzaCreator(pizza: Pizza? = nil) {
        let pizzaCreatorVC = coreAssembler.resolvePizzaCreatorViewController(pizza: pizza)
        self.navigationController?.pushViewController(pizzaCreatorVC.viewController, animated: true)
    }
}
