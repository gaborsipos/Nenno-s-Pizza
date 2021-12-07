//
//  DataStoreService.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

class DataStoreService {
    // MARK: - Properties

    private let dataStoreFactory: DataStoreFactory

    // MARK: - Initialization

    init(dataStoreFactory: @escaping DataStoreFactory) {
        self.dataStoreFactory = dataStoreFactory
    }

    // MARK: - Functions

    func setValue<ValueType>(_ value: ValueType, forPath path: DataStoreValuePath) {
        guard let dataStore = dataStore(forDomain: path.domain) else {
            return
        }

        do {
            try dataStore.setValue(value, forKey: path.key)
        } catch let error {
            assertionFailure("Couldn't set value \(value) for key \(path.key) in domain \(path.domain.rawValue): \(error)")
        }
    }

    func value<ValueType>(forPath path: DataStoreValuePath) -> ValueType? {
        guard let dataStore = dataStore(forDomain: path.domain) else {
            return nil
        }

        do {
            return try dataStore.value(forKey: path.key)
        } catch let error {
            assertionFailure("Couldn't get value for key \(path.key) in domain \(path.domain.rawValue): \(error)")
            return nil
        }
    }

    func removeValue(forPath path: DataStoreValuePath) {
        guard let dataStore = dataStore(forDomain: path.domain) else {
            return
        }

        do {
            try dataStore.removeValue(forKey: path.key)
        } catch let error {
            assertionFailure("Couldn't remove value for key \(path.key) in domain \(path.domain.rawValue): \(error)")
        }
    }

    private func dataStore(forDomain domain: DataStoreDomainProtocol) -> DataStoreProtocol? {
        guard let dataStore = dataStoreFactory(domain) else {
            assertionFailure("Couldn't get dataStore for domain \(domain.rawValue).")
            return nil
        }

        return dataStore
    }
}

// MARK: - DataStoreServiceProtocol

extension DataStoreService: DataStoreServiceProtocol {
    func removeAllValues(forDomain domain: DataStoreDomainProtocol) {
        guard let dataStore = dataStore(forDomain: domain) else {
            return
        }

        do {
            try dataStore.removeAllValues()
        } catch let error {
            assertionFailure("Couldn't remove all values in domain \(domain.rawValue): \(error)")
        }
    }

    func removeAllValues(forDomains domains: [DataStoreDomainProtocol]) {
        for domain in domains {
            removeAllValues(forDomain: domain)
        }
    }
}
