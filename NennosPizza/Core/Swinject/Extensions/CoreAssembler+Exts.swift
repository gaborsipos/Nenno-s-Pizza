//
//  CoreAssembler+Exts.swift
//  NennosPizza
//
//  Created by Gabor Sipos on 2021. 12. 06..
//

import Swinject

extension Assembler {
    func resolveDataStoreFactory() -> DataStoreFactory {
        return resolver.resolve(DataStoreFactory.self)!
    }
}
