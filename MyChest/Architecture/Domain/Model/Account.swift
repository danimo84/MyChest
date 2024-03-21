//
//  Account.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftData

@Model
class Account: ModelDefault {
    
    @Attribute(.unique) var id: String
    var user: String
    var password: String
    var domain: String
    var domainProtocol: String
    var image: String
    var comment: String
    var rememberUpdateMonths: Int
    var createdAt: Date
    var updatedAt: Date
    
    init(
        user: String,
        password: String,
        domain: String,
        domainProtocol: String,
        image: String,
        comment: String,
        rememberUpdateMonths: Int,
        createdAt: Date,
        updatedAt: Date
    ) {
        self.id = UUID().uuidString
        self.user = user
        self.password = password
        self.domain = domain
        self.domainProtocol = domainProtocol
        self.image = image
        self.comment = comment
        self.rememberUpdateMonths = rememberUpdateMonths
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

extension Account {
    
    static func empty() -> Account {
        .init(
            user: "",
            password: "",
            domain: "",
            domainProtocol: DomainProtocol.http.rawValue,
            image: "",
            comment: "",
            rememberUpdateMonths: 0,
            createdAt: .now,
            updatedAt: .now
        )
    }

    static func mock() -> Account {
        .init(
            user: "danimo321",
            password: "123123",
            domain: "google.com",
            domainProtocol: DomainProtocol.http.rawValue,
            image: "",
            comment: "Cuenta para publicidad.",
            rememberUpdateMonths: 1,
            createdAt: Date(timeIntervalSince1970: 1300),
            updatedAt: Date(timeIntervalSince1970: 1000)
        )
    }
    
    static func mockList() -> [Account] {
        [
            .init(
                user: "danimo321",
                password: "123123",
                domain: "google.com",
                domainProtocol: DomainProtocol.http.rawValue,
                image: "",
                comment: "Cuenta para publicidad.",
                rememberUpdateMonths: 0,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000)
            ),
            .init(
                user: "danimo321",
                password: "123123",
                domain: "facebook.com",
                domainProtocol: DomainProtocol.http.rawValue,
                image: "",
                comment: "",
                rememberUpdateMonths: 12,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000)
            ),
            .init(
                user: "danimo321",
                password: "123123",
                domain: "linkedin.com",
                domainProtocol: DomainProtocol.https.rawValue,
                image: "",
                comment: "",
                rememberUpdateMonths: 5,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000)
            ),
            .init(
                user: "danimo321",
                password: "123123",
                domain: "instagram.com",
                domainProtocol: DomainProtocol.https.rawValue,
                image: "",
                comment: "Cuenta personal.",
                rememberUpdateMonths: 2,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000)
            ),
            .init(
                user: "danimo321",
                password: "123123",
                domain: "discord.com",
                domainProtocol: DomainProtocol.https.rawValue,
                image: "",
                comment: "Cuenta de trabajo."
                ,
                rememberUpdateMonths: 6,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000)
            )
        ]
    }
}

