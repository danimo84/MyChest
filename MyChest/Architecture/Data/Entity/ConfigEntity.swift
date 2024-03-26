//
//  ConfigEntity.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/3/24.
//

import Foundation

struct ConfigEntity: Entity {
    
    let id: String
    let charactersNumber: Int
    let requireUpper: Bool
    let requireLower: Bool
    let requireNumber: Bool
    let requireSpecialCharacter: Bool
    let storeInKeyChain: Bool
    let areNotificationsEnabled: Bool
}
