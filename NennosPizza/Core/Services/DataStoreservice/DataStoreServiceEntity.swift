//
//  DataStoreServiceEntity.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

enum DataStoreDomain: String, CaseIterable, DataStoreDomainProtocol {
    /// Store in UserDefaultsDataStore
    case generalPersistent

    /// Store in MemoryDataStore
    case generalMemory
}

typealias DataStoreFactory = (DataStoreDomainProtocol) -> DataStoreProtocol?

/**
 * Defines a path (key + domain) for a value in the data store framework.
 */
struct DataStoreValuePath {
    // MARK: - Properties

    let key: String
    let domain: DataStoreDomainProtocol

    // MARK: - Initialization

    init(key: String, domain: DataStoreDomainProtocol) {
        self.key = key
        self.domain = domain
    }
}
