//
//  PizzaCreatorViewModel.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 07..
//

import RxSwift

final class PizzaCreatorViewModel: ScreenViewModel {
    // MARK: - Properties

    let ingredientCells = PublishSubject<[CartCellModel]>()
    let totalPrice = PublishSubject<String>()
    let addToCartButtonEnabled = BehaviorSubject<Bool>(value: false)
    var pizza: Pizza?
    let pizzaPublisher = PublishSubject<Pizza>()
    private let doclerApiSerivce: DoclerApiServiceProtocol
    private let appDataStoreService: AppDataStoreServiceProtocol

    // MARK: - Initialization

    init(doclerApiSerivce: DoclerApiServiceProtocol, appDataStoreService: AppDataStoreServiceProtocol, pizza: Pizza?) {
        self.doclerApiSerivce = doclerApiSerivce
        self.appDataStoreService = appDataStoreService
        self.pizza = pizza

        super.init()

        subscribers()
    }

    // MARK: - ScreenViewModel functions

    override func loadData() {
        guard pizza != nil else {
            createCustomPizza()

            return
        }

        updatePublishers()
    }

    // MARK: - Functions

    func addPizzaToCart() {
        guard let pizza = pizza else { return }

        appDataStoreService.addPizzaToCart(pizza)
        showSnackbar("Added to cart")
    }

    private func subscribers() {
        pizzaPublisher
            .subscribe(onNext: { [weak self] pizza in
                guard let self = self else { return }

                let models = pizza.ingredients.map { ingredient in
                    CartCellModel(
                        imageName: ingredient.isAdded ? "checkmark" : nil,
                        title: ingredient.name,
                        price: ingredient.price,
                        tap: {
                            var tmpPizza = pizza
                            if let index = tmpPizza.ingredients.firstIndex(where: { $0.id == ingredient.id }) {
                                tmpPizza.ingredients[index].isAdded = !tmpPizza.ingredients[index].isAdded
                                self.pizza = tmpPizza
                                self.updatePublishers()
                            }
                        }
                    )
                }

                self.ingredientCells.onNext(models)
            })
            .disposed(by: disposeBag)
    }

    private func createCustomPizza() {
        Observable.combineLatest(doclerApiSerivce.fetchPizzas(), doclerApiSerivce.fetchIngredients())
            .map { [weak self] pizzaResponse, allIngredients in
                let ingredients = allIngredients.map { ingredient -> Pizza.Ingredient in
                    Pizza.Ingredient(id: ingredient.id, name: ingredient.name, price: ingredient.price, isAdded: false)
                }

                self?.pizza = Pizza(name: "Custom pizza",
                                    basePrice: pizzaResponse.basePrice,
                                    ingredients: ingredients,
                                    imageUrl: nil)
            }
            .subscribe(onNext: { [weak self] in
                self?.updatePublishers()
            })
            .disposed(by: disposeBag)
    }

    private func updatePublishers() {
        guard let pizza = pizza else { return }

        pizzaPublisher.onNext(pizza)

        let price = pizza.price
        let formattedPrice = amountFormatter.string(from: NSNumber(value: price)) ?? String(price)

        totalPrice.onNext("ADD TO CART (\(formattedPrice))")

        addToCartButtonEnabled.onNext(pizza.addedIngredients.count > 0)
    }
}
