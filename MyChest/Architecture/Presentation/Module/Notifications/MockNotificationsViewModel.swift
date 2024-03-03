//
//  MockNotificationsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation

final class MockNotificationsViewModel: NotificationsViewModel {
    
    var notifications: [LocalNotification] = LocalNotification.mockList()
    
    func onAppear() {
        // Intentionally empty
    }
    
    func onNotificationTapppedWithId(_ id: String, accountId: String) {
        // Intentionally empty
    }
}
