//
//  LocalNotificationRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Combine

// sourcery: AutoMockable
protocol LocalNotificationRepository {
    func fetchNotifications() -> AnyPublisher<[LocalNotificationEntity], DataError>
    func insertNotification(_ notification: LocalNotificationEntity)
    func updateNotification(_ notification: LocalNotificationEntity)
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
    
    func fetchNotifications() -> AnyPublisher<[LocalNotificationEntity], DataError> {
        localDataSource.fetchNotifications()
    }
    
    func insertNotification(_ notification: LocalNotificationEntity) {
        localDataSource.insertNotification(notification)
    }
    
    func updateNotification(_ notification: LocalNotificationEntity) {
        localDataSource.updateNotification(notification)
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
