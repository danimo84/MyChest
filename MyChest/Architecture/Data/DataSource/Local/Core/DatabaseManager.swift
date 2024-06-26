//
//  DatabaseManager.swift
//  MyChest
//
//  Created by Daniel Moraleda on 23/1/24.
//

import SwiftData

enum StorageModels {
    static var models = [
        AccountEntityCache.self,
        ConfigEntityCache.self,
        LocalNotificationEntityCache.self,
        UserEntityCache.self
    ] as [any PersistentModel.Type]
}

final class DatabaseManager {
    
    var modelContainer: ModelContainer
    var modelContext: ModelContext
    
    @MainActor
    static let shared = DatabaseManager()
    
    @MainActor
    private init() {
        modelContainer = {
            let schema = Schema(StorageModels.models)
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(for: schema, configurations: [modelConfiguration])
            } catch {
                fatalError("Could not create ModelContainer: \(error)")
            }
        }()
        modelContext = modelContainer.mainContext
    }
    
    @MainActor 
    func clearAll() {
        for model in StorageModels.models {
            do {
                try modelContainer.mainContext.delete(model: model)
            } catch {
                print("Failed to clear all database info...")
            }
        }
    }
}
