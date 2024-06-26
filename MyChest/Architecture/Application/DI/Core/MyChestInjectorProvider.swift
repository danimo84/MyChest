//
//  MyChestInjectorProvider.swift
//  PokemonSwiftUI
//
//  Created by Daniel Moraleda on 20/10/23.
//

import Foundation
import Swinject

class MyChestInjectorProvider: InjectorProvider, Injector {
    
    typealias Update = (Container) -> Void
    
    static let shared: InjectorProvider = MyChestInjectorProvider()
    
    let container: Container = Container()
    
    var injector: Injector {
        return self
    }
    
    // MARK: Add Injectios
    
    func add(_ moduleType: InjectorModule.Type) -> Self {
        let module: InjectorModule = moduleType.init()
        module.injector = self
        module.configure(container)
        
        return self
    }
    
    func updateInjection<T>(type: T.Type, withObject object: T) {
        updateInjection(type: type, withName: nil, withObject: object)
    }
    
    func updateInjection<T>(type: T.Type, withName name: String?, withObject object: T) {
        container.register(type, name: name) { _ -> T in
            object
        }
    }
    
    // MARK: Request instances
    
    func instanceOf<T>(_ type: T.Type) -> T {
        guard let instance = container.resolve(type) else {
            let message: String = "Can't retrieve instance of \(type)"
            print(message)
            fatalError(message)
        }
        return instance
    }
    
    func instanceOf<T>(_ type: T.Type, name: String) -> T {
        guard let instance = container.resolve(type, name: name) else {
            let message: String = "Can't retrieve instance of \(type) for name \(name)"
            print(message)
            fatalError(message)
        }
        return instance
    }
    
    func instanceOf<T, U>(_ type: T.Type, param: U) -> T {
        guard let instance = container.resolve(type, argument: param) else {
            let message: String = "Can't retrieve instance of \(type) with param \(param)"
            print(message)
            fatalError(message)
        }
        return instance
    }
    
    func instanceOf<T, U, V>(_ type: T.Type, params param1: U, _ param2: V) -> T {
        guard let instance = container.resolve(type, arguments: param1, param2) else {
            let message: String = "Can't retrieve instance of \(type) with params \(param1) \(param2)"
            print(message)
            fatalError(message)
        }
        return instance
    }
}
