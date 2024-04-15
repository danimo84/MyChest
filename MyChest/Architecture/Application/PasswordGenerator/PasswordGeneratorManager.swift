//
//  PasswordGeneratorManager.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/1/24.
//

import Foundation

// sourcery: AutoMockable
protocol PasswordGeneratorManager {
    func generatePasswordWithConfig(_ config: ConfigEntity) -> String
}

final class PasswordGeneratorManagerDefault: PasswordGeneratorManager {
    
    func generatePasswordWithConfig(_ config: ConfigEntity) -> String {
        String((0..<config.charactersNumber).compactMap { _ in
            allowedCharacters(config).randomElement()
        })
    }
}

private extension PasswordGeneratorManagerDefault {
    
    func allowedCharacters(_ config: ConfigEntity) -> String {
        let config = (config.requireUpper ? Theme.PasswordGenerator.letters.uppercased() : "")
            .appending(config.requireLower ? Theme.PasswordGenerator.letters : "")
            .appending(config.requireNumber ? Theme.PasswordGenerator.numbers : "")
            .appending(config.requireSpecialCharacter ? Theme.PasswordGenerator.special : "")
        
        return config
    }
}
