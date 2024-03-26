//
//  LocalNotificationRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation
import Combine

protocol LocalNotificationRepository {
    func fetchNotifications() -> AnyPublisher<[LocalNotification], LocalNotificationError>
    func insertNotification(_ notification: LocalNotification)
    func updateNotification(_ notification: LocalNotification)
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
    
    func fetchNotifications() -> AnyPublisher<[LocalNotification], LocalNotificationError> {
        localDataSource.fetchNotifications()
            .map {
                $0.map { LocalNotificationMapper.map($0) }
                    .sorted { $0.datetime > $1.datetime }
            }
            .mapError { LocalNotificationErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    func insertNotification(_ notification: LocalNotification) {
        localDataSource.insertNotification(LocalNotificationMapper.mapToEntity(notification))
    }
    
    func updateNotification(_ notification: LocalNotification) {
        localDataSource.updateNotification(LocalNotificationMapper.mapToEntity(notification))
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
