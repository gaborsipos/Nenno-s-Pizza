//
//  CartViewModel.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxSwift

final class CartViewModel: ScreenViewModel {
    // MARK: - Properties

    let cartCells = PublishSubject<[CartCellModel]>()
    let totalPrice = PublishSubject<String>()
    let checkoutButtonEnabled = BehaviorSubject<Bool>(value: false)
    let showCheckoutSuccess = PublishSubject<Void>()
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
        appDataStoreService.cartPublisher
            .subscribe(onNext: { [weak self] cart in
                guard let self = self else { return }

                var models = cart.pizzas.map { pizza in
                    CartCellModel(
                        imageName: "multiply",
                        title: pizza.name,
                        price: pizza.price,
                        tap: {
                            self.appDataStoreService.removePizzaFromCart(pizza)
                        }
                    )
                }

                models.append(contentsOf: cart.drinks.map { drink in
                    CartCellModel(
                        imageName: "multiply",
                        title: drink.name,
                        price: drink.price,
                        tap: {
                            self.appDataStoreService.removeDrinkFromCart(drink)
                        }
                    )
                })

                self.cartCells.onNext(models)

                let price = cart.price
                let formattedPrice = amountFormatter.string(from: NSNumber(value: price)) ?? String(price)

                self.totalPrice.onNext("CHECKOUT (\(formattedPrice))")

                self.checkoutButtonEnabled.onNext(!cart.isEmpty)
            })
            .disposed(by: disposeBag)
    }

    // MARK: - Functions

    func checkout() {
        checkoutButtonEnabled.onNext(false)

        doclerApiSerivce.checkout(cart: appDataStoreService.cart)
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }

                self.showCheckoutSuccess.onNext(())
                self.appDataStoreService.deleteCart()
            })
            .disposed(by: disposeBag)
    }
}
