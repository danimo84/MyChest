//
//  AppDelegate+Injections.swift
//  PokemonSwiftUI
//
//  Created by Daniel Moraleda on 20/10/23.
//

import Foundation
import Swinject

extension AppDelegate {
    
    func configureDependencyInjection() {
        _ = MyChestInjectorProvider.shared
            .add(MyChestModule.self)
    }
}
