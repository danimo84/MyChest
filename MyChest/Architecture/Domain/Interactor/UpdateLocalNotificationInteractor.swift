//
//  UpdateLocalNotificationInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 4/4/24.
//

import Combine

// sourcery: AutoMockable
protocol UpdateLocalNotificationInteractor {
    func execute(_ notification: LocalNotification)
}

final class UpdateLocalNotificationInteractorDefault {
    
    private let notificationRepository: LocalNotificationRepository
    
    init(notificationRepository: LocalNotificationRepository) {
        self.notificationRepository = notificationRepository
    }
}

extension UpdateLocalNotificationInteractorDefault: UpdateLocalNotificationInteractor {
    
    func execute(_ notification: LocalNotification) {
        notificationRepository.updateNotification(LocalNotificationMapper.mapToEntity(notification))
    }
}
