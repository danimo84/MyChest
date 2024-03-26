//
//  ConfigMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/3/24.
//

import Foundation

struct ConfigMapper {
    
    static func map(_ entity: ConfigEntity) -> Config {
        .init(
            id: entity.id,
            charactersNumber: entity.charactersNumber,
            requireUpper: entity.requireUpper,
            requireLower: entity.requireLower,
            requireNumber: entity.requireNumber,
            requireSpecialCharacter: entity.requireSpecialCharacter,
            storeInKeyChain: entity.storeInKeyChain,
            areNotificationsEnabled: entity.areNotificationsEnabled
        )
    }
    
    static func mapToEntity(_ model: Config) -> ConfigEntity {
        .init(
            id: model.id,
            charactersNumber: model.charactersNumber,
            requireUpper: model.requireUpper,
            requireLower: model.requireLower,
            requireNumber: model.requireNumber,
            requireSpecialCharacter: model.requireSpecialCharacter,
            storeInKeyChain: model.storeInKeyChain,
            areNotificationsEnabled: model.areNotificationsEnabled
        )
    }
}
