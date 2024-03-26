//
//  ConfigEntityMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/3/24.
//

import Foundation

struct ConfigEntityMapper {
    
    static func map(_ cache: ConfigEntityCache) -> ConfigEntity {
        .init(
            id: cache.id,
            charactersNumber: cache.charactersNumber,
            requireUpper: cache.requireUpper,
            requireLower: cache.requireLower,
            requireNumber: cache.requireNumber,
            requireSpecialCharacter: cache.requireSpecialCharacter,
            storeInKeyChain: cache.storeInKeyChain,
            areNotificationsEnabled: cache.areNotificationsEnabled
        )
    }
}
