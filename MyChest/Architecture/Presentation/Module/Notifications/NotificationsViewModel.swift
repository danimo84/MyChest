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
    
    func getNotifications()
    func markNotifAsReadedAndNavigate(_ id: String, accountId: String)
}

final class NotificationsViewModelDefault {
    
    @Published var notifications: [LocalNotification] = []
    private var subscriptions = Set<AnyCancellable>()
    
    private let getLocalNotificationInteractor: GetLocalNotificationInteractor
    private let updateLocalNotificationInteractor: UpdateLocalNotificationInteractor
    
    init(
        getLocalNotificationInteractor: GetLocalNotificationInteractor,
        updateLocalNotificationInteractor: UpdateLocalNotificationInteractor
    ) {
        self.getLocalNotificationInteractor = getLocalNotificationInteractor
        self.updateLocalNotificationInteractor = updateLocalNotificationInteractor
    }
}

extension NotificationsViewModelDefault: NotificationsViewModel {
    
    func getNotifications() {
        Task { await fetchNotifications() }
    }
    
    func markNotifAsReadedAndNavigate(_ id: String, accountId: String) {
        markNotificationAsReadedWithId(id)
        navigateToAccountWithId(accountId)
    }
}

private extension NotificationsViewModelDefault {
    
    @MainActor
    func fetchNotifications() async {
        do {
            notifications = try await getLocalNotificationInteractor.execute().async()
        } catch(let error) {
            print("Error: \(error)")
        }
    }
    
    func markNotificationAsReadedWithId(_ id: String) {
        guard let index = notifications.firstIndex(where: { $0.id == id }) else {
            return
        }
        notifications[index].isReaded = true
        updateLocalNotificationInteractor.execute(notifications[index])
    }
}

private extension NotificationsViewModelDefault {
    
    func navigateToAccountWithId(_ id: String) {
        Router.shared.navigateToAccountsAndStoreRoutingToId(id)
    }
}
