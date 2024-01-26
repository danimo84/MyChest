//
//  InjectorModule.swift
//  PokemonSwiftUI
//
//  Created by Daniel Moraleda on 20/10/23.
//

import Foundation
import Swinject

class InjectorModule: Injector {
    
    private static let errorMessage: String = "Injector is nil"
    
    weak var injector: Injector?
    
    required init() {}
    
    func configure(_ container: Container) {
        // Intentionally empty
    }
    
    func instanceOf<T>(_ type: T.Type) -> T {
        guard let injector = self.injector else {
            fatalError(Self.errorMessage)
        }
        
        return injector.instanceOf(type)
    }
    
    func instanceOf<T>(_ type: T.Type, name: String) -> T {
        guard let injector = self.injector else {
            fatalError(Self.errorMessage)
        }
        
        return injector.instanceOf(type, name: name)
    }
    
    func instanceOf<T, U>(_ type: T.Type, param: U) -> T {
        guard let injector = self.injector else {
            fatalError(Self.errorMessage)
        }
        
        return injector.instanceOf(type, param: param)
    }
    
    func instanceOf<T, U, V>(_ type: T.Type, params param1: U, _ param2: V) -> T {
        guard let injector = self.injector else {
            fatalError(Self.errorMessage)
        }
        
        return injector.instanceOf(type, params: param1, param2)
    }
}
