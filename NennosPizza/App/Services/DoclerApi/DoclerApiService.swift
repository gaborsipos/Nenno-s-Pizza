//
//  DoclerApiService.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import Moya
import RxSwift

final class DoclerApiService {
    // MARK: - Types

    struct Pizza: Codable {
        let name: String
        let ingredients: [Int]
        let imageUrl: String?
    }

    struct Ingredient: Decodable {
        let id: Int
        let name: String
        let price: Double
    }

    struct Drink: Codable {
        let id: Int
        let name: String
        let price: Double
    }

    // MARK: - Properties

    private let provider: MoyaProvider<DoclerApi>

    // MARK: - Initialization

    init() {
        provider = MoyaProvider<DoclerApi>(
            plugins: [NetworkLoggerPlugin()]
        )
    }

    // MARK: - Functions

    private func request<D: Decodable>(target: DoclerApi) -> Observable<D> {
        .create { [weak self] observer -> Disposable in
            guard let self = self else { return Disposables.create {} }

            return self.provider.rx
                .request(target)
                .filterSuccessfulStatusAndRedirectCodes()
                .map(D.self)
                .subscribe(
                    onSuccess: { response in
                        observer.onNext(response)
                    },
                    onFailure: { error in
                        observer.onError(error)
                    }
                )
        }
    }

    private func request(target: DoclerApi) -> Completable {
        provider.rx
            .request(target)
            .filterSuccessfulStatusAndRedirectCodes()
            .asCompletable()
    }
}

extension DoclerApiService: DoclerApiServiceProtocol {
    func fetchPizzas() -> Observable<PizzaResponse> {
        request(target: .pizzas)
    }

    func fetchIngredients() -> Observable<[Ingredient]> {
        request(target: .ingredients)
    }

    func fetchDrinks() -> Observable<[Drink]> {
        request(target: .drinks)
    }

    func pizzas() -> Observable<[NennosPizza.Pizza]> {
        Observable.combineLatest(fetchPizzas(), fetchIngredients())
            .map { pizzaResponse, allIngredients -> [NennosPizza.Pizza] in
                pizzaResponse.pizzas.map { pizza -> NennosPizza.Pizza in
                    let ingredients = allIngredients.map { ingredient -> NennosPizza.Pizza.Ingredient in
                        let isAdded = pizza.ingredients.contains(ingredient.id)

                        return NennosPizza.Pizza.Ingredient(id: ingredient.id, name: ingredient.name, price: ingredient.price, isAdded: isAdded)
                    }

                    return NennosPizza.Pizza(name: pizza.name,
                                             basePrice: pizzaResponse.basePrice,
                                             ingredients: ingredients,
                                             imageUrl: pizza.imageUrl)
                }
            }
    }

    func checkout(cart: Cart) -> Completable {
        let pizzas = cart.pizzas.map { pizza -> Pizza in
            let ingredients = pizza.ingredients.map({ $0.id })
            return Pizza(name: pizza.name, ingredients: ingredients, imageUrl: pizza.imageUrl)
        }

        let drinks = cart.drinks.map({ Drink(id: $0.id, name: $0.name, price: $0.price) })

        if cart.isEmpty {
            return Completable.never()
        }

        return request(target: .checkout(params: CheckoutRequestParams(pizzas: pizzas, drinks: drinks)))
    }
}
