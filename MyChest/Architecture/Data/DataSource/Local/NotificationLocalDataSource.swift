//
//  LocalNotificationLocalDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation
import Combine

protocol LocalNotificationLocalDataSource {
    func fetchNotifications() -> AnyPublisher<[LocalNotificationEntity], DataError>
    func insertNotification(_ notification: LocalNotificationEntity)
    func updateNotification(_ notification: LocalNotificationEntity)
    func removeNotificationsWithAccountId(_ accountId: String)
    func removePendingNotificationsWithAccountId(_ accountId: String)
    func removeAllNotifications()
}

final class LocalNotificationLocalDataSourceDefault {
    
    private let databaseManager = DatabaseManager.shared
    
    init() {
        // Intentionally empty
    }
}

extension LocalNotificationLocalDataSourceDefault: LocalNotificationLocalDataSource {
    
    func fetchNotifications() -> AnyPublisher<[LocalNotificationEntity], DataError> {
        Just(
            LocalNotificationEntityCache.fetchNotifications(context: databaseManager.modelContext)
        )
        .setFailureType(to: DataError.self)
        .map{ $0.map { LocalNotificationEntityMapper.map($0) } }
        .eraseToAnyPublisher()
    }
    
    func insertNotification(_ notification: LocalNotificationEntity) {
        LocalNotificationEntityCache.insertNotification(
            LocalNotificationEntityMapper.mapToCache(notification),
            using: databaseManager.modelContext
        )
    }
    
    func updateNotification(_ notification: LocalNotificationEntity) {
        _ = LocalNotificationEntityCache.updateNotification(
            notification,
            using: databaseManager.modelContext
        )
    }
    
    func removeNotificationsWithAccountId(_ accountId: String) {
        LocalNotificationEntityCache.removeNotification(
            withId: accountId,
            using: databaseManager.modelContext
        )
    }
    
    func removePendingNotificationsWithAccountId(_ accountId: String) {
        LocalNotificationEntityCache.removePendingNotification(
            withId: accountId,
            using: databaseManager.modelContext
        )
    }
    
    func removeAllNotifications() {
        LocalNotificationEntityCache.removeAllNotifications(using: databaseManager.modelContext)
    }
}
