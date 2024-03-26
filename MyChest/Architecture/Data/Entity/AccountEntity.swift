//
//  AccountEntity.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/3/24.
//

import Foundation

struct AccountEntity: Entity {
    
    let id: String
    let user: String
    let password: String
    let domain: String
    let domainProtocol: String
    let image: String
    let comment: String
    let rememberUpdateMonths: Int
    let createdAt: Date
    let updatedAt: Date
}
