//
//  PokemonModule.swift
//  PokemonSwiftUI
//
//  Created by Daniel Moraleda on 20/10/23.
//

import Foundation
import Swinject

class MyChestModule: InjectorModule {
    
    override func configure(_ container: Container) {
        configureAccounts(container)
    }
    
    private func configureAccounts(_ container: Container) {
        container.register(AccountLocalDataSource.self) { _ in
            AccountLocalDataSourceDefault()
        }
        .inObjectScope(.container)
        
        container.register(AccountRepository.self) { r in
            AccountRepositoryDefault(localDataSource: r.resolve(AccountLocalDataSource.self)!)
        }
        .inObjectScope(.container)
    }
}
