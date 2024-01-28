//
//  Config.swift
//  MyChest
//
//  Created by Daniel Moraleda on 22/1/24.
//

import Foundation
import SwiftData

@Model
class Config: ModelDefault {
    
    let id: String
    var charactersNumber: Int
    var requireUpper: Bool
    var requireLower: Bool
    var requireNumber: Bool
    var requireSpecialCharacter: Bool
    var storeInKeyChain: Bool
    var areNotificationsEnabled: Bool
    
    init(
        charactersNumber: Int,
        requireUpper: Bool,
        requireLower: Bool,
        requireNumber: Bool,
        requireSpecialCharacter: Bool,
        storeInKeyChain: Bool,
        areNotificationsEnabled: Bool
    ) {
        self.id = UUID().uuidString
        self.charactersNumber = charactersNumber
        self.requireUpper = requireUpper
        self.requireLower = requireLower
        self.requireNumber = requireNumber
        self.requireSpecialCharacter = requireSpecialCharacter
        self.storeInKeyChain = storeInKeyChain
        self.areNotificationsEnabled = areNotificationsEnabled
    }
}

extension Config {
    
    static func defaultConfig() -> Config {
        .init(
            charactersNumber: 16,
            requireUpper: true,
            requireLower: true,
            requireNumber: true,
            requireSpecialCharacter: true,
            storeInKeyChain: false,
            areNotificationsEnabled: false
        )
    }
}
