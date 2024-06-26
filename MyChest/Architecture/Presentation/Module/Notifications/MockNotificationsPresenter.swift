//
//  MockNotificationsPresenter.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation

final class MockNotificationsPresenter: NotificationsPresenter {
   
    @Published var notifications: [LocalNotification] = []
    
    func getNotifications() {
        // Intentionally empty
    }
    
    func markNotifAsReadedAndNavigate(_ id: String, accountId: String) {
        // Intentionally empty
    }
}
