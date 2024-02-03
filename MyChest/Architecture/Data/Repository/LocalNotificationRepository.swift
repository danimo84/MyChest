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
    }
    
    func insertNotification(_ notification: LocalNotification) {
        localDataSource.insertNotification(notification)
    }
    
    func removeNotification(_ notification: LocalNotification) {
        localDataSource.removeNotification(notification)
    }
    
    func removeAllNotifications() {
        localDataSource.removeAllNotifications()
    }
}

private extension LocalNotificationRepositoryDefault {
    
}
