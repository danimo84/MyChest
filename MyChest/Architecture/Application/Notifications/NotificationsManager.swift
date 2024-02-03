//
//  NotificationsManager.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation
import UserNotifications

protocol NotificationsManager {
    func scheduleNotifications(_ notifications: [LocalNotification])
    func handleNotification(_ notificationUserInfo: [AnyHashable: Any])
}

final class NotificationsManagerDefault: NSObject {
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
}

extension NotificationsManagerDefault: NotificationsManager {
    
    func scheduleNotifications(_ notifications: [LocalNotification]) {
        for notification in notifications {
            let triggerDateTime = Calendar.current.dateComponents([.hour, .minute, .second], from: notification.datetime)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateTime, repeats: notification.repeats)
            let request = UNNotificationRequest(identifier: notification.id, content: getNotificationContent(notification), trigger: trigger)
            scheduleNotification(request)
        }
    }
    
    func handleNotification(_ notificationUserInfo: [AnyHashable: Any]) {
        // TODO: - Handle notification tap route
    }
}

extension NotificationsManagerDefault: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
        -> Void
    ) {
        completionHandler([[.banner, .list, .sound]])
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        handleNotification(response.notification.request.content.userInfo)
        completionHandler()
    }
}

private extension NotificationsManagerDefault {
    
    func getNotificationContent(_ notification: LocalNotification) -> UNNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body
        content.sound = .default
        return content
    }
    
    func scheduleNotification(_ request: UNNotificationRequest) {
        UNUserNotificationCenter.current().add(request) { error in
            guard error == nil else {
                return
            }
            print("Notification scheduled with ID = \(request.identifier)")
        }
    }
}
