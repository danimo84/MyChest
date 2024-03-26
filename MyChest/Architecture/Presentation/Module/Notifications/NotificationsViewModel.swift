//
//  NotificationsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation
import Combine

protocol NotificationsViewModel: ObservableObject {
    var notifications: [LocalNotification] { get set }
    
    func onAppear()
    func onNotificationTapppedWithId(_ id: String, accountId: String)
}

final class NotificationsViewModelDefault {
    
    @Published var notifications: [LocalNotification] = []
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let notificationRepository: LocalNotificationRepository
    
    init(notificationRepository: LocalNotificationRepository) {
        self.notificationRepository = notificationRepository
    }
}

extension NotificationsViewModelDefault: NotificationsViewModel {
    
    func onAppear() {
        fetchNotifications()
    }
    
    func onNotificationTapppedWithId(_ id: String, accountId: String) {
        markNotificationAsReadedWithId(id)
        navigateToAccountWithId(accountId)
    }
}

private extension NotificationsViewModelDefault {
    
    func fetchNotifications() {
        notificationRepository.fetchNotifications()
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Error: \(error)")
                    }
                },
                receiveValue: {
                    self.notifications = $0
                }
            )
            .store(in: &subscriptions)
    }
    
    func markNotificationAsReadedWithId(_ id: String) {
        if let index = notifications.firstIndex(where: { $0.id == id }) {
            notifications[index].isReaded = true
            notificationRepository.updateNotification(notifications[index])
        }
    }
    
    func navigateToAccountWithId(_ id: String) {
        Router.shared.navigateToAccountsAndStoreRoutingToId(id)
    }
}
