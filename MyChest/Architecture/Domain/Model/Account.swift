//
//  Account.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct Account: ModelDefault {
    
    let id: String
    var user: String
    var password: String
    var domain: String
    var domainProtocol: String
    var image: String
    var comment: String
    var rememberUpdateMonths: Int
    var createdAt: Date
    var updatedAt: Date
}

extension Account {
    
    static func empty() -> Account {
        .init(
            id: UUID().uuidString,
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
    
    static func emptyMock() -> Account {
        .init(
            id: UUID().uuidString,
            user: "",
            password: "",
            domain: "",
            domainProtocol: DomainProtocol.http.rawValue,
            image: "",
            comment: "",
            rememberUpdateMonths: 0,
            createdAt: Date(timeIntervalSince1970: 1300),
            updatedAt: Date(timeIntervalSince1970: 1000)
        )
    }

    static func mock() -> Account {
        .init(
            id: UUID().uuidString,
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
                id: UUID().uuidString,
                user: "danimo321",
                password: "123123",
                domain: "netflix.com",
                domainProtocol: DomainProtocol.http.rawValue,
                image: "",
                comment: "Cuenta para publicidad.",
                rememberUpdateMonths: 0,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000)
            ),
            .init(
                id: UUID().uuidString,
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
                id: UUID().uuidString,
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
                id: UUID().uuidString,
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
                id: UUID().uuidString,
                user: "danimo321",
                password: "123123",
                domain: "hbomax.com",
                domainProtocol: DomainProtocol.https.rawValue,
                image: "https://hbomax-images.warnermediacdn.com/2020-05/square%20social%20logo%20400%20x%20400_0.png",
                comment: "Cuenta de trabajo."
                ,
                rememberUpdateMonths: 6,
                createdAt: Date(timeIntervalSince1970: 1300),
                updatedAt: Date(timeIntervalSince1970: 1000)
            )
        ]
    }
}

