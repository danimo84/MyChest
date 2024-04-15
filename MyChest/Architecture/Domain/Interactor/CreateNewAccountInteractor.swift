//
//  CreateNewAccountInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/4/24.
//

import Combine

// sourcery: AutoMockable
protocol CreateNewAccountInteractor {
    func execute(account: Account)
}

final class CreateNewAccountInteractorDefault {
    
    private let accountRepository: AccountRepository
    private let notificationRepository: LocalNotificationRepository
    private let notificationsManager: NotificationsManager
    
    init(
        accountRepository: AccountRepository,
        notificationRepository: LocalNotificationRepository,
        notificationsManager: NotificationsManager
    ) {
        self.accountRepository = accountRepository
        self.notificationRepository = notificationRepository
        self.notificationsManager = notificationsManager
    }
}

extension CreateNewAccountInteractorDefault: CreateNewAccountInteractor {
    
    func execute(account: Account) {
        accountRepository.inserAccount(AccountMapper.mapToEntity(account))
        guard account.rememberUpdateMonths != .zero,
        let notification = LocalNotification.buildLocalNotificationForAccount(account) else {
            return
        }
        notificationsManager.scheduleNotifications([notification])
        notificationRepository.insertNotification(LocalNotificationMapper.mapToEntity(notification))
    }
}
