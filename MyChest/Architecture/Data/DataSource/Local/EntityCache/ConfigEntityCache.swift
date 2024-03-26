//
//  ConfigEntityCache.swift
//  MyChest
//
//  Created by Daniel Moraleda on 22/1/24.
//

import Foundation
import SwiftData

@Model
class ConfigEntityCache {
    
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

extension ConfigEntityCache {
    
    static func defaultConfig() -> ConfigEntityCache {
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

extension ConfigEntityCache {
    
    static func fetchConfig(context: ModelContext) -> ConfigEntityCache? {
        (try? context.fetch(fetchDescriptor))?.first
    }
    
    static func insertConfig(
        _ config: ConfigEntityCache,
        using context: ModelContext
    ) {
        context.insert(config)
        try? context.save()
    }
    
    static func updateConfig(
        _ config: ConfigEntity,
        using context: ModelContext
    ) -> ConfigEntityCache? {
        defer { try? context.save() }
        return fetchOrCreate(config: config, using: context)
    }
}

private extension ConfigEntityCache {
    
    static var fetchDescriptor: FetchDescriptor<ConfigEntityCache> {
        .init()
    }
    
    static func updateCache(
        _ cache: ConfigEntityCache,
        withConfig config: ConfigEntity,
        using context: ModelContext
    ) -> ConfigEntityCache? {
        guard config.id == cache.id else {
            return nil
        }
        cache.charactersNumber = config.charactersNumber
        cache.requireUpper = config.requireUpper
        cache.requireLower = config.requireLower
        cache.requireNumber = config.requireNumber
        cache.requireSpecialCharacter = config.requireSpecialCharacter
        cache.storeInKeyChain = config.storeInKeyChain
        cache.areNotificationsEnabled = config.areNotificationsEnabled
        
        return cache
    }
    
    static func fetchOrCreate(
        config: ConfigEntity,
        using context: ModelContext
    ) -> ConfigEntityCache? {
        if let confiCache = (try? context.fetch(fetchDescriptor))?.first {
            return updateCache(confiCache, withConfig: config, using: context)
        }
        return defaultConfig()
    }
}
