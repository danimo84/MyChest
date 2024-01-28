//
//  ConfigLocalDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/1/24.
//

import Foundation
import SwiftData

protocol ConfigLocalDataSource {
    func fetchConfig() -> Config
}

final class ConfigLocalDataSourceDefault: ConfigLocalDataSource {
    
    private let databaseManager = DatabaseManager.shared
    
    init() {
        
    }
    
    func fetchConfig() -> Config {
        do {
            return try databaseManager.modelContext.fetch(FetchDescriptor<Config>()).first ?? storeDefaultConfig()
        } catch {
            print("Error fetching Config")
        }
        return .defaultConfig()
    }
    
    func insertConfig(_ config: Config) {
        databaseManager.modelContext.insert(config)
        do {
            try databaseManager.modelContext.save()
        } catch {
            print("Error inserting Config: \(config)")
        }
    }
}

private extension ConfigLocalDataSourceDefault {
    
    func storeDefaultConfig() -> Config {
        insertConfig(.defaultConfig())
        return .defaultConfig()
    }
}
