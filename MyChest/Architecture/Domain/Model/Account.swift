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
    
    var id: String
    var user: String
    var password: String
    var domain: String
    var image: String
    var comment: String
    var rememberUpdateMonths: Int
    
    init(
        user: String,
        password: String,
        domain: String,
        image: String,
        comment: String,
        rememberUpdateMonths: Int
    ) {
        self.id = UUID().uuidString
        self.user = user
        self.password = password
        self.domain = domain
        self.image = image
        self.comment = comment
        self.rememberUpdateMonths = rememberUpdateMonths
    }
}

extension Account {
    
    static func empty() -> Account {
        .init(
            user: "",
            password: "",
            domain: "",
            image: "",
            comment: "",
            rememberUpdateMonths: 0
        )
    }

    static func mock() -> Account {
        .init(
            user: "danimo321",
            password: "123123",
            domain: "google.com",
            image: "",
            comment: "Cuenta para publicidad.",
            rememberUpdateMonths: 1
        )
    }
    
    static func mockList() -> [Account] {
        [
            .init(
                user: "danimo321",
                password: "123123",
                domain: "google.com",
                image: "",
                comment: "Cuenta para publicidad.",
                rememberUpdateMonths: 0
            ),
            .init(
                user: "danimo321",
                password: "123123",
                domain: "facebook.com",
                image: "",
                comment: "",
                rememberUpdateMonths: 12
            ),
            .init(
                user: "danimo321",
                password: "123123",
                domain: "linkedin.com",
                image: "",
                comment: "",
                rememberUpdateMonths: 5
            ),
            .init(
                user: "danimo321",
                password: "123123",
                domain: "instagram.com",
                image: "",
                comment: "Cuenta personal.",
                rememberUpdateMonths: 2
            ),
            .init(
                user: "danimo321",
                password: "123123",
                domain: "discord.com",
                image: "",
                comment: "Cuenta de trabajo."
                ,
                rememberUpdateMonths: 6
            )
        ]
    }
}

