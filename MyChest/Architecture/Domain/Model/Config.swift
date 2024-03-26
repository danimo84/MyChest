//
//  Config.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/3/24.
//

import Foundation

struct Config: ModelDefault {
    
    let id: String
    var charactersNumber: Int
    var requireUpper: Bool
    var requireLower: Bool
    var requireNumber: Bool
    var requireSpecialCharacter: Bool
    var storeInKeyChain: Bool
    var areNotificationsEnabled: Bool
}

extension Config {
    
    static func defaultConfig() -> Config {
        .init(
            id: UUID().uuidString,
            charactersNumber: 16,
            requireUpper: true,
            requireLower: true,
            requireNumber: true,
            requireSpecialCharacter: true,
            storeInKeyChain: false,
            areNotificationsEnabled: false
        )
    }
    
    static func defaultConfig(
        id: String,
        notificationsEnabled: Bool
    ) -> Config {
        .init(
            id: id,
            charactersNumber: 16,
            requireUpper: true,
            requireLower: true,
            requireNumber: true,
            requireSpecialCharacter: true,
            storeInKeyChain: false,
            areNotificationsEnabled: notificationsEnabled
        )
    }
}
