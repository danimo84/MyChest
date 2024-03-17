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
    func removeNotificationsWithAccountId(_ accountId: String)
    func removePendingNotificationsWithAccountId(_ accountId: String)
    func removeAllNotifications()
}

final class LocalNotificationLocalDataSourceDefault {
    
    private let databaseManager = DatabaseManager.shared
    
    init() { }
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
    
    func removeNotificationsWithAccountId(_ accountId: String) {
        do {
            try databaseManager.modelContext.delete(model: LocalNotification.self, where: #Predicate { notification in
                notification.accountId == accountId
            })
        } catch {
            print("Error deleting Notificaitons for account id: \(accountId)")
        }
    }
    
    func removePendingNotificationsWithAccountId(_ accountId: String) {
        let now: Date = .now
        do {
            try databaseManager.modelContext.delete(model: LocalNotification.self, where: #Predicate { notification in
                notification.accountId == accountId && notification.datetime < now
            })
        } catch {
            print("Error deleting Pending Notificaitons for account id: \(accountId)")
        }
    }
    
    func removeAllNotifications() {
        do {
            try databaseManager.modelContext.delete(model: LocalNotification.self)
        } catch {
            print("Error deleting all Notificaitons")
        }
    }
}
