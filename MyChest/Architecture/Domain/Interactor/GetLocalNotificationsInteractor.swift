//
//  GetLocalNotificationInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 4/4/24.
//

import Combine

protocol GetLocalNotificationInteractor {
    func execute() -> AnyPublisher<[LocalNotification], LocalNotificationError>
}

final class GetLocalNotificationInteractorDefault {
    
    private let notificationRepository: LocalNotificationRepository
    
    init(notificationRepository: LocalNotificationRepository) {
        self.notificationRepository = notificationRepository
    }
}

extension GetLocalNotificationInteractorDefault: GetLocalNotificationInteractor {
    
    func execute() -> AnyPublisher<[LocalNotification], LocalNotificationError> {
        notificationRepository.fetchNotifications()
            .map {
                $0.map { LocalNotificationMapper.map($0) }
                    .sorted { $0.datetime > $1.datetime }
            }
            .mapError { LocalNotificationErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
}
