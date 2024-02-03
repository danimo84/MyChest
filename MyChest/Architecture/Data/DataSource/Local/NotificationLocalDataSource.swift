//
//  LocalNotificationLocalDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation
import SwiftData

protocol LocalNotificationLocalDataSource {
    func fetchNotifications() -> [LocalNotification]
    func insertNotification(_ notification: LocalNotification)
    func removeNotification(_ notification: LocalNotification)
    func removeAllNotifications()
}

final class LocalNotificationLocalDataSourceDefault {
    
    private let databaseManager = DatabaseManager.shared
    
    init() {
        
    }
}

extension LocalNotificationLocalDataSourceDefault: LocalNotificationLocalDataSource {
    
    func fetchNotifications() -> [LocalNotification] {
        do {
            return try databaseManager.modelContext.fetch(FetchDescriptor<LocalNotification>())
        } catch {
            print("Error fetching Notification")
            return []
        }
    }
    
    func insertNotification(_ notification: LocalNotification) {
        databaseManager.modelContext.insert(notification)
        do {
            try databaseManager.modelContext.save()
        } catch {
            print("Error inserting Notification: \(notification)")
        }
    }
    
    func removeNotification(_ notification: LocalNotification) {
        databaseManager.modelContext.delete(notification)
    }
    
    func removeAllNotifications() {
        do {
            try databaseManager.modelContext.delete(model: LocalNotification.self)
        } catch {
            print("Error deleting all Notificaitons")
        }
    }
}
