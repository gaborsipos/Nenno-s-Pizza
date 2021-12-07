//
//  DataStoreAssembly.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import Swinject

final class DataStoreAssembly: RootAssembly {
    // MARK: - RootAssembly functions

    override func assemble(container: Container) {
        super.assemble(container: container)

        container.register(DataStoreProtocol.self, name: DataStoreDomain.generalPersistent.rawValue) { _ in
            guard let dataStore = UserDefaultsDataStore(suiteName: DataStoreDomain.generalPersistent.rawValue) else {
                assertionFailure(
                    "Couldn't create UserDefaults for suite \(DataStoreDomain.generalPersistent.rawValue). Fall back to the standard UserDefaults."
                )

                return UserDefaultsDataStore()
            }

            return dataStore
        }.inObjectScope(.container)

        container.register(DataStoreProtocol.self, name: DataStoreDomain.generalMemory.rawValue) { _ in
            return MemoryDataStore()
        }.inObjectScope(.container)

        container.register(DataStoreFactory.self) { resolver -> DataStoreFactory in
            return { domain in
                return resolver.resolve(DataStoreProtocol.self, name: domain.rawValue)
            }
        }
    }
}
