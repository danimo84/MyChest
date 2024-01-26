//
//  Injector.swift
//  PokemonSwiftUI
//
//  Created by Daniel Moraleda on 20/10/23.
//

import Foundation

protocol Injector: AnyObject {
    func instanceOf<T>(_ type: T.Type) -> T
    func instanceOf<T>(_ type: T.Type, name: String) -> T
    func instanceOf<T, U>(_ type: T.Type, param: U) -> T
    func instanceOf<T, U, V>(_ type: T.Type, params param1: U, _ param2: V) -> T
}
