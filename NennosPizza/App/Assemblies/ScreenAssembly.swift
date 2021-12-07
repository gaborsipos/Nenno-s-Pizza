//
//  ScreenAssembly.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import Swinject

final class ScreenAssembly: RootAssembly {
    // MARK: - RootAssembly functions

    override func assemble(container: Container) {
        super.assemble(container: container)

        registerHomeViewController(container)
        registerPizzaCreatorViewController(container)
        registerCartViewController(container)
        registerDrinksViewController(container)
        registerCheckoutSuccessViewController(container)
    }

    // MARK: - Functions

    private func registerHomeViewController(_ container: Container) {
        container.register(HomeViewControllerProtocol.self) { _ in
            let doclerApiSerivce = coreAssembler.resolveDoclerApiService()
            let appDataStoreService = coreAssembler.resolveAppDataStoreService()
            let viewModel = HomeViewModel(doclerApiSerivce: doclerApiSerivce, appDataStoreService: appDataStoreService)
            return HomeViewController(viewModel: viewModel)
        }
    }

    private func registerPizzaCreatorViewController(_ container: Container) {
        container.register(PizzaCreatorViewControllerProtocol.self) { (_, pizza: Pizza?) in
            let doclerApiSerivce = coreAssembler.resolveDoclerApiService()
            let appDataStoreService = coreAssembler.resolveAppDataStoreService()
            let viewModel = PizzaCreatorViewModel(doclerApiSerivce: doclerApiSerivce, appDataStoreService: appDataStoreService, pizza: pizza)
            return PizzaCreatorViewController(viewModel: viewModel)
        }
    }

    private func registerCartViewController(_ container: Container) {
        container.register(CartViewControllerProtocol.self) { _ in
            let doclerApiSerivce = coreAssembler.resolveDoclerApiService()
            let appDataStoreService = coreAssembler.resolveAppDataStoreService()
            let viewModel = CartViewModel(doclerApiSerivce: doclerApiSerivce, appDataStoreService: appDataStoreService)
            return CartViewController(viewModel: viewModel)
        }
    }

    private func registerDrinksViewController(_ container: Container) {
        container.register(DrinksViewControllerProtocol.self) { _ in
            let doclerApiSerivce = coreAssembler.resolveDoclerApiService()
            let appDataStoreService = coreAssembler.resolveAppDataStoreService()
            let viewModel = DrinksViewModel(doclerApiSerivce: doclerApiSerivce, appDataStoreService: appDataStoreService)
            return DrinksViewController(viewModel: viewModel)
        }
    }

    private func registerCheckoutSuccessViewController(_ container: Container) {
        container.register(CheckoutSuccessViewControllerProtocol.self) { _ in
            let viewModel = CheckoutSuccessViewModel()
            return CheckoutSuccessViewController(viewModel: viewModel)
        }
    }
}
