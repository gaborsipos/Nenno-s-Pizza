//
//  GlobalVariables.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import Swinject

let coreAssembler = Assembler()

var amountFormatter: NumberFormatter = {
    let amountFormatter = NumberFormatter()
    amountFormatter.usesGroupingSeparator = true
    amountFormatter.numberStyle = .currency
    amountFormatter.currencyCode = "USD"

    return amountFormatter
}()
