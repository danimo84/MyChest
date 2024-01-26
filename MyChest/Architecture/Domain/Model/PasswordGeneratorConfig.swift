//
//  PasswordGeneratorConfig.swift
//  MyChest
//
//  Created by Daniel Moraleda on 22/1/24.
//

import Foundation
import SwiftData

@Model
class PasswordGeneratorConfig: ModelDefault {
    
    let id: String
    var charactersNumber: Int
    var requireUpper: Bool
    var requireLower: Bool
    var requireLetter: Bool
    var requireNumber: Bool
    var requireSpecialCharacter: Bool
    
    init(
        charactersNumber: Int,
        requireUpper: Bool,
        requireLower: Bool,
        requireLetter: Bool,
        requireNumber: Bool,
        requireSpecialCharacter: Bool
    ) {
        self.id = UUID().uuidString
        self.charactersNumber = charactersNumber
        self.requireUpper = requireUpper
        self.requireLower = requireLower
        self.requireLetter = requireLetter
        self.requireNumber = requireNumber
        self.requireSpecialCharacter = requireSpecialCharacter
    }
}

extension PasswordGeneratorConfig {
    
    static func defaultConfig() -> PasswordGeneratorConfig {
        .init(
            charactersNumber: 16,
            requireUpper: true,
            requireLower: true,
            requireLetter: true,
            requireNumber: true,
            requireSpecialCharacter: true
        )
    }
}
