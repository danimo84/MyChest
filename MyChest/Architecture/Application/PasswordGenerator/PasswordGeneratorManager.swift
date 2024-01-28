//
//  PasswordGeneratorManager.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/1/24.
//

import Foundation

protocol PasswordGeneratorManager {
    func generatePasswordWithConfig(_ config: Config) -> String
}

final class  PasswordGeneratorManagerDefault: PasswordGeneratorManager {
    
    func generatePasswordWithConfig(_ config: Config) -> String {
        
        String((0..<config.charactersNumber).compactMap { _ in
            allowedCharacters(config).randomElement()
        })
    }
}

private extension PasswordGeneratorManagerDefault {
    
    func allowedCharacters(_ config: Config) -> String {
        let config = (config.requireUpper ? Constants.PasswordGenerator.letters.uppercased() : "")
            .appending(config.requireLower ? Constants.PasswordGenerator.letters : "")
            .appending(config.requireNumber ? Constants.PasswordGenerator.numbers : "")
            .appending(config.requireSpecialCharacter ? Constants.PasswordGenerator.special : "")
        
        return config
    }
}
