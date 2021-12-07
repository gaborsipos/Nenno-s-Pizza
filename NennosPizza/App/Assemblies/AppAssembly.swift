//
//  AppAssembly.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import Swinject

final class AppAssembly: RootAssembly {
    // MARK: - RootAssembly functions

    override func assemble(container: Container) {
        super.assemble(container: container)

        registerAppDataStoreService(container)
        registerDoclerApiService(container)
    }

    // MARK: - Functions

    private func registerAppDataStoreService(_ container: Container) {
        container.register(AppDataStoreServiceProtocol.self) { _ in
            return AppDataStoreService(dataStoreFactory: coreAssembler.resolveDataStoreFactory())
        }.inObjectScope(.container)
    }

    private func registerDoclerApiService(_ container: Container) {
        container.register(DoclerApiServiceProtocol.self) { _ in
            return DoclerApiService()
        }.inObjectScope(.container)
    }
}
