//
//  DoclerApiServiceProtocol.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import RxSwift

protocol DoclerApiServiceProtocol {
    func fetchPizzas() -> Observable<PizzaResponse>
    func fetchIngredients() -> Observable<[DoclerApiService.Ingredient]>
    func fetchDrinks() -> Observable<[DoclerApiService.Drink]>
    func pizzas() -> Observable<[Pizza]>
    func checkout(cart: Cart) -> Completable
}
