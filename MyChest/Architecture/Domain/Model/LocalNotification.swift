//
//  LocalNotification.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation
import SwiftData

@Model
class LocalNotification: ModelDefault {
    
    @Attribute(.unique) var id: String
    var accountId: String
    var title: String
    var body: String
    var datetime: Date
    var repeats: Bool
    var createdAt: Date
    var updatedAt: Date
    var isReaded: Bool
    @Transient var isSent: Bool {
        datetime < .now
    }
    
    init(
        id: String,
        accountId: String,
        title: String,
        body: String,
        datetime: Date,
        repeats: Bool,
        createdAt: Date,
        updatedAt: Date,
        isReaded: Bool
    ) {
        self.id = id
        self.accountId = accountId
        self.title = title
        self.body = body
        self.datetime = datetime
        self.repeats = repeats
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.isReaded = isReaded
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
