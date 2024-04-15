//
//  UpdateRememberPasswordNotificationInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/4/24.
//

import Combine

// sourcery: AutoMockable
protocol UpdateRememberPasswordNotificationInteractor {
    func execute(account: Account)
}

final class UpdateRememberPasswordNotificationInteractorDefault {
    
    private let notificationRepository: LocalNotificationRepository
    private let notificationsManager: NotificationsManager
    
    init(
        notificationRepository: LocalNotificationRepository,
        notificationsManager: NotificationsManager
    ) {
        self.notificationRepository = notificationRepository
        self.notificationsManager = notificationsManager
    }
}

extension UpdateRememberPasswordNotificationInteractorDefault: UpdateRememberPasswordNotificationInteractor {
    
    func execute(account: Account) {
        notificationsManager.cancelPendingNotificationWithAccountId(account.id)
        notificationRepository.removePendingNotificationsWithAccountId(account.id)
        guard account.rememberUpdateMonths != .zero,
        let notification = LocalNotification.buildLocalNotificationForAccount(account) else {
            return
        }
        notificationsManager.scheduleNotifications([notification])
        notificationRepository.insertNotification(LocalNotificationMapper.mapToEntity(notification))
    }
}
