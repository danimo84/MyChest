//
//  LocalNotification.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/3/24.
//

import Foundation

struct LocalNotification: ModelDefault {
    
    let id: String
    let accountId: String
    let title: String
    let body: String
    let datetime: Date
    let repeats: Bool
    var createdAt: Date
    var updatedAt: Date
    var isReaded: Bool
}

extension LocalNotification {
    
    var isSent: Bool {
        datetime < .now
    }
}

extension LocalNotification {
    
    static func buildLocalNotificationForAccount(_ account: Account) -> LocalNotification? {
        guard let date = Calendar.current.date(byAdding: .second, value: account.rememberUpdateMonths * 10, to: .now) else {
            return nil
        }
        return .init(
            id: UUID().uuidString,
            accountId: account.id,
            title: Strings.NotificationsScreen.passwordUpdateTitle,
            body: Strings.NotificationsScreen.passwordUpdateBody(
                domain: account.domain,
                monthsNumber: account.rememberUpdateMonths
            ),
            datetime: date,
            repeats: false,
            createdAt: .now,
            updatedAt: .now,
            isReaded: false
        )
    }
}

extension LocalNotification {
    
    static func empty() -> LocalNotification {
        .init(
            id: UUID().uuidString,
            accountId: UUID().uuidString,
            title: "Recordatorio",
            body: "Actualiza la contraseña de Netflix.com",
            datetime: Date(timeIntervalSince1970: 1000),
            repeats: false,
            createdAt: .now,
            updatedAt: .now,
            isReaded: false
        )
    }

    static func mock() -> LocalNotification {
        .init(
            id: UUID().uuidString,
            accountId: UUID().uuidString,
            title: "Recordatorio",
            body: "Actualiza la contraseña de Netflix.com",
            datetime: Date(timeIntervalSince1970: 1000),
            repeats: false,
            createdAt: Date(timeIntervalSince1970: 1300),
            updatedAt: Date(timeIntervalSince1970: 1000),
            isReaded: false
        )
    }
    
    static func mockList() -> [LocalNotification] {
        [
            .init(
                id: UUID().uuidString,
                accountId: UUID().uuidString,
                title: "Recordatorio",
                body: "Actualiza la contraseña de Netflix.com",
                datetime: Date(timeIntervalSince1970: 1000),
                repeats: false,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000),
                isReaded: false
            ),
            .init(
                id: UUID().uuidString,
                accountId: UUID().uuidString,
                title: "Recordatorio",
                body: "Actualiza la contraseña de as.com",
                datetime: Date(timeIntervalSince1970: 1010),
                repeats: false,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000),
                isReaded: false
            ),
            .init(
                id: UUID().uuidString,
                accountId: UUID().uuidString,
                title: "Recordatorio",
                body: "Actualiza la contraseña de gmail.com",
                datetime: Date(timeIntervalSince1970: 2000),
                repeats: false,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000),
                isReaded: false
            ),
            .init(
                id: UUID().uuidString,
                accountId: UUID().uuidString,
                title: "Recordatorio",
                body: "Actualiza la contraseña de Netflix.com",
                datetime: Date(timeIntervalSince1970: 2400),
                repeats: false,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000),
                isReaded: true
            )
        ]
    }
}
