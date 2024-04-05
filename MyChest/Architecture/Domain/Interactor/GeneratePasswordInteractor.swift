//
//  GeneratePasswordInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 4/4/24.
//

import Foundation

protocol GeneratePasswordInteractor {
    func execute(_ config: Config) -> String
}

final class GeneratePasswordInteractorDefault {
    
    private let passwordGeneratorManager: PasswordGeneratorManager
    
    init(passwordGeneratorManager: PasswordGeneratorManager) {
        self.passwordGeneratorManager = passwordGeneratorManager
    }
}

extension GeneratePasswordInteractorDefault: GeneratePasswordInteractor {
    
    func execute(_ config: Config) -> String {
        passwordGeneratorManager.generatePasswordWithConfig(ConfigMapper.mapToEntity(config))
    }
}
