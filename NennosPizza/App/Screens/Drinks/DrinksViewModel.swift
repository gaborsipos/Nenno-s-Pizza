//
//  DrinksViewModel.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxSwift

final class DrinksViewModel: ScreenViewModel {
    // MARK: - Properties

    let drinkCells = PublishSubject<[CartCellModel]>()

    private let doclerApiSerivce: DoclerApiServiceProtocol
    private let appDataStoreService: AppDataStoreServiceProtocol

    // MARK: - Initialization

    init(doclerApiSerivce: DoclerApiServiceProtocol, appDataStoreService: AppDataStoreServiceProtocol) {
        self.doclerApiSerivce = doclerApiSerivce
        self.appDataStoreService = appDataStoreService

        super.init()
    }

    override func loadData() {
        doclerApiSerivce.fetchDrinks()
            .subscribe(onNext: { [weak self] drinks in
                guard let self = self else { return }

                let models = drinks.map { drink in
                    CartCellModel(
                        imageName: "plus",
                        title: drink.name,
                        price: drink.price,
                        tap: {
                            self.appDataStoreService.addDrinkToCart(Drink(id: drink.id, name: drink.name, price: drink.price))
                            self.showSnackbar("Added to cart")
                        }
                    )
                }

                self.drinkCells.onNext(models)
            })
            .disposed(by: disposeBag)
    }
}
