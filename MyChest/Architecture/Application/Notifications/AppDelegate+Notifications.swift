//
//  AppDelegate+Notifications.swift
//  MyChest
//
//  Created by Daniel Moraleda on 5/2/24.
//

import Foundation

extension AppDelegate {
    
    func initNotificationsManger() {
        var injector: Injector {
            MyChestInjectorProvider.shared.injector
        }
        _ = injector.instanceOf(NotificationsManager.self)
    }
}
