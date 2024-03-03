//
//  NotificationsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation

protocol NotificationsViewModel: ObservableObject {
    var notifications: [LocalNotification] { get set }
    
    func onAppear()
    func onNotificationTapppedWithId(_ id: String, accountId: String)
}

final class NotificationsViewModelDefault {
    
    @Published var notifications: [LocalNotification] = []
    
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
        notifications = notificationRepository.fetchNotifications()
    }
    
    func markNotificationAsReadedWithId(_ id: String) {
        notifications.first(where: { $0.id == id } )?.isReaded = true
    }
    
    func navigateToAccountWithId(_ id: String) {
        Router.shared.navigateToAccountsAndStoreRoutingToId(id)
    }
}
