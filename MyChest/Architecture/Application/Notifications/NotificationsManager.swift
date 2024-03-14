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
    func cancelPendingNotificationWithAccountId(_ id: String)
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
    
    func cancelPendingNotificationWithAccountId(_ id: String) {
        cancelScheduledNotificationsForAccountId(id)
    }
    
    func handleNotification(_ notificationUserInfo: [AnyHashable: Any]) {
        guard let payload = NotificationPayload(notificationUserInfo) else {
            return
        }
        switch payload.notificationType {
        case .updatePasswordReminder:
            navigateToAccountWithPayload(payload)
        case .none:
            return
        }
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
        content.userInfo = [
            "type": "update_password_reminder",
            "id_account": "\(notification.accountId)"
        ]
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
    
    func cancelScheduledNotificationsForAccountId(_ id: String) {
        UNUserNotificationCenter.current().getPendingNotificationRequests {
            for notification: UNNotificationRequest in $0 {
                if let idAccount = notification.content.userInfo["id_account"] as? String,
                   idAccount == id {
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notification.identifier])
                }
            }
        }
    }
}

private extension NotificationsManagerDefault {
    
    func navigateToAccountWithPayload(_ payload: NotificationPayload) {
        guard let idAccount = payload.idAccount else {
            return
        }
        Router.shared.navigateToAccountsAndStoreRoutingToId(idAccount)
    }
}
