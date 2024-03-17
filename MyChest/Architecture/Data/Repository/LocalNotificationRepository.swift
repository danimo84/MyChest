//
//  LocalNotificationRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation

protocol LocalNotificationRepository {
    func fetchNotifications() -> [LocalNotification]
    func insertNotification(_ notification: LocalNotification)
    func removeNotification(_ notification: LocalNotification)
    func removeNotificationsWithAccountId(_ accountId: String)
    func removePendingNotificationsWithAccountId(_ accountId: String)
    func removeAllNotifications()
}

final class LocalNotificationRepositoryDefault {
    
    private let localDataSource: LocalNotificationLocalDataSource
    
    init(localDataSource: LocalNotificationLocalDataSource) {
        self.localDataSource = localDataSource
    }
}

extension LocalNotificationRepositoryDefault: LocalNotificationRepository {
    
    func fetchNotifications() -> [LocalNotification] {
        localDataSource.fetchNotifications()
            .sorted { $0.datetime > $1.datetime }
    }
    
    func insertNotification(_ notification: LocalNotification) {
        localDataSource.insertNotification(notification)
    }
    
    func removeNotification(_ notification: LocalNotification) {
        localDataSource.removeNotification(notification)
    }
    
    func removeNotificationsWithAccountId(_ accountId: String) {
        localDataSource.removeNotificationsWithAccountId(accountId)
    }
    
    func removePendingNotificationsWithAccountId(_ accountId: String) {
        localDataSource.removePendingNotificationsWithAccountId(accountId)
    }
    
    func removeAllNotifications() {
        localDataSource.removeAllNotifications()
    }
}
