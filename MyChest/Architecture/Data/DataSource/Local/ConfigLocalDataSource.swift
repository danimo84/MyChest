//
//  ConfigLocalDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/1/24.
//

import Foundation
import Combine

protocol ConfigLocalDataSource {
    func fetchConfig() -> AnyPublisher<ConfigEntity, DataError>
    func updateConfig(_ config: ConfigEntity)
}

final class ConfigLocalDataSourceDefault: ConfigLocalDataSource {
    
    private let databaseManager = DatabaseManager.shared
    
    init() { }
    
    func fetchConfig() -> AnyPublisher<ConfigEntity, DataError> {
        Just(
            ConfigEntityCache.fetchConfig(context: databaseManager.modelContext) ?? storeDefaultConfig()
        )
        .setFailureType(to: DataError.self)
        .map {
            ConfigEntityMapper.map($0)
        }
        .eraseToAnyPublisher()
    }
    
    func updateConfig(_ config: ConfigEntity) {
        _ = ConfigEntityCache.updateConfig(
            config,
            using: databaseManager.modelContext
        )
    }
}

private extension ConfigLocalDataSourceDefault {
    
    func storeDefaultConfig() -> ConfigEntityCache {
        ConfigEntityCache.insertConfig(
            .defaultConfig(),
            using: databaseManager.modelContext
        )
        return .defaultConfig()
    }
}
