//
//  MemoryDataStore.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

/**
 * Stores key-value pairs in memory.
 */
class MemoryDataStore {
    // MARK: - Properties

    private var dictionary = [String: Any]()

    // MARK: - Initialization

    init() {
    }
}

// MARK: - DataStoreProtocol

extension MemoryDataStore: DataStoreProtocol {
    func setValue<ValueType>(_ value: ValueType, forKey key: String) throws {
        dictionary[key] = value
    }

    func value<ValueType>(forKey key: String) throws -> ValueType? {
        return dictionary[key] as? ValueType
    }

    func removeValue(forKey key: String) throws {
        dictionary.removeValue(forKey: key)
    }

    func removeAllValues() throws {
        dictionary.removeAll()
    }
}
