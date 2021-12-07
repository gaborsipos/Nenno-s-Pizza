//
//  RootAssembly.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import Swinject

class RootAssembly {
    // MARK: - Initialization

    init() {
    }

    // MARK: - RootAssemblyProtocol functions

    func assemble(container: Container) {
    }

    func loaded(resolver: Resolver) {
    }
}

// MARK: - RootAssemblyProtocol

extension RootAssembly: RootAssemblyProtocol {
}
