//
//  GetLocalNotificationInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 8/4/24.
//

import Combine

// sourcery: AutoMockable
protocol GetLocalNotificationInteractor {
    func execute() -> AnyPublisher<[LocalNotification], GetLocalNotificationError>
}

final class GetLocalNotificationInteractorDefault {
    
    private let notificationRepository: LocalNotificationRepository
    
    init(notificationRepository: LocalNotificationRepository) {
        self.notificationRepository = notificationRepository
    }
}

extension GetLocalNotificationInteractorDefault: GetLocalNotificationInteractor {
    
    func execute() -> AnyPublisher<[LocalNotification], GetLocalNotificationError> {
        notificationRepository.fetchNotifications()
            .map {
                $0.map { LocalNotificationMapper.map($0) }
                    .sorted { $0.datetime > $1.datetime }
            }
            .mapError { GetLocalNotificationErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
}
