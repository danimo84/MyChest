//
//  AccountMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct AccountMapper {
    
    static func map(_ entity: AccountEntity) -> Account {
        .init(
            id: entity.id,
            user: entity.user,
            password: entity.password,
            domain: entity.domain,
            domainProtocol: entity.domainProtocol,
            image: entity.image,
            comment: entity.comment,
            rememberUpdateMonths: entity.rememberUpdateMonths,
            createdAt: entity.createdAt,
            updatedAt: entity.updatedAt
        )
    }
    
    static func mapToEntity(_ model: Account) -> AccountEntity {
        .init(
            id: model.id,
            user: model.user,
            password: model.password,
            domain: model.domain,
            domainProtocol: model.domainProtocol,
            image: model.image,
            comment: model.comment,
            rememberUpdateMonths: model.rememberUpdateMonths,
            createdAt: model.createdAt,
            updatedAt: model.updatedAt
        )
    }
}
