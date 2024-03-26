//
//  AccountEntityMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/3/24.
//

import Foundation

struct AccountEntityMapper {
    
    static func map(_ cache: AccountEntityCache) -> AccountEntity {
        .init(
            id: cache.id,
            user: cache.user,
            password: cache.password,
            domain: cache.domain,
            domainProtocol: cache.domainProtocol,
            image: cache.image,
            comment: cache.comment,
            rememberUpdateMonths: cache.rememberUpdateMonths,
            createdAt: cache.createdAt,
            updatedAt: cache.updatedAt
        )
    }
    
    static func mapToCache(_ entity: AccountEntity) -> AccountEntityCache {
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
}
