//
//  NotificationPayload.swift
//  MyChest
//
//  Created by Daniel Moraleda on 5/2/24.
//

import Foundation

enum NotificationType: String, Hashable {
    case updatePasswordReminder = "update_password_reminder"
}

struct NotificationPayload: Codable {
    
    let notification: String?
    let idAccount: String?
    
    var notificationType: NotificationType? {
        NotificationType(rawValue: notification ?? "")
    }
    
    init?(_ userInfo: [AnyHashable: Any]) {
        guard let notification = userInfo["type"] as? String,
              let idAccount = userInfo["id_account"] as? String else {
            return nil
        }
        self.notification = notification
        self.idAccount = idAccount
    }
}
