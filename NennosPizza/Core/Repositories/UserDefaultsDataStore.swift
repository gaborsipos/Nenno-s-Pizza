//
//  UserDefaultsDataStore.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import Foundation

class UserDefaultsDataStore {
    // MARK: - Properties

    private let userDefaults: UserDefaults

    // MARK: - Initialization

    /**
     * Creates a UserDefaults for the given suiteName.
     */
    init?(suiteName: String) {
        guard let userDefaults = UserDefaults(suiteName: suiteName) else {
            return nil
        }

        self.userDefaults = userDefaults
    }

    /**
     * Using the standard UserDefaults.
     */
    init() {
        userDefaults = UserDefaults.standard
    }
}

// MARK: - DataStoreProtocol

extension UserDefaultsDataStore: DataStoreProtocol {
    func setValue<ValueType>(_ value: ValueType, forKey key: String) throws {
        userDefaults.set(value, forKey: key)
    }

    func value<ValueType>(forKey key: String) throws -> ValueType? {
        return userDefaults.object(forKey: key) as? ValueType
    }

    func removeValue(forKey key: String) throws {
        userDefaults.removeObject(forKey: key)
    }

    func removeAllValues() throws {
        let keys = Array(userDefaults.dictionaryRepresentation().keys)
        for key in keys {
            userDefaults.removeObject(forKey: key)
        }
    }
}
