//
//  DataStoreProtocol.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

/**
 * Repositories are storing key-value pairs.
 */
protocol DataStoreProtocol {
    /**
     * Updates the value for the given key, or stores the value for the given key if the key doesn't exist.
     */
    func setValue<ValueType>(_ value: ValueType, forKey key: String) throws

    /**
     * Returns the value for the given key. Returns nil if the key doesn't exist.
     */
    func value<ValueType>(forKey key: String) throws -> ValueType?

    /**
     * Removes the value for the given key. Does nothing if the key doesn't exist.
     */
    func removeValue(forKey key: String) throws

    /**
     * Removes all the values.
     */
    func removeAllValues() throws
}
