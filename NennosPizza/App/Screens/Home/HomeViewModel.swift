//
//  HomeViewModel.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxSwift

final class HomeViewModel: ScreenViewModel {
    // MARK: - Properties

    let pizzas = PublishSubject<[Pizza]>()

    private let doclerApiSerivce: DoclerApiServiceProtocol
    private let appDataStoreService: AppDataStoreServiceProtocol

    // MARK: - Initialization

    init(doclerApiSerivce: DoclerApiServiceProtocol, appDataStoreService: AppDataStoreServiceProtocol) {
        self.doclerApiSerivce = doclerApiSerivce
        self.appDataStoreService = appDataStoreService

        super.init()
    }

    // MARK: - ScreenViewModel functions

    override func loadData() {
        doclerApiSerivce.pizzas()
            .subscribe(onNext: { [weak self] pizzas in
                guard let self = self else { return }

                self.pizzas.onNext(pizzas)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Functions

    func addPizzaToCart(_ pizza: Pizza) {
        appDataStoreService.addPizzaToCart(pizza)
        showSnackbar("Added to cart")
    }
}
