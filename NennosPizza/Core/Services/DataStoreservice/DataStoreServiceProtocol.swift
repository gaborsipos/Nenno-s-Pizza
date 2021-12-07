//
//  DataStoreServiceProtocol.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

/**
 * A String enum should implement this to enumarate the data store's domains of the application.
 */
protocol DataStoreDomainProtocol {
    var rawValue: String { get }
}

protocol DataStoreServiceProtocol {
    /**
     * Removes all the values for the given domain.
     */
    func removeAllValues(forDomain domain: DataStoreDomainProtocol)

    /**
     * Removes all the values for the given domains.
     */
    func removeAllValues(forDomains domains: [DataStoreDomainProtocol])
}
