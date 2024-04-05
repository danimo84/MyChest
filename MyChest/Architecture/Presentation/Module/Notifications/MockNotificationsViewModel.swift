//
//  MockNotificationsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation

final class MockNotificationsViewModel: NotificationsViewModel {
   
    var notifications: [LocalNotification] = LocalNotification.mockList()
    
    func getNotifications() {
        // Intentionally empty
    }
    
    func markNotifAsReadedAndNavigate(_ id: String, accountId: String) {
        // Intentionally empty
    }
}
