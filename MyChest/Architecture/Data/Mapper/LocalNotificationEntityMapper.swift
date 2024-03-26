//
//  LocalNotificationEntityMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/3/24.
//

import Foundation

struct LocalNotificationEntityMapper {
    
    static func map(_ cache: LocalNotificationEntityCache) -> LocalNotificationEntity {
        .init(
            id: cache.id,
            accountId: cache.accountId,
            title: cache.title,
            body: cache.body,
            datetime: cache.datetime,
            repeats: cache.repeats,
            createdAt: cache.createdAt,
            updatedAt: cache.updatedAt,
            isReaded: cache.isReaded
        )
    }
    
    static func mapToCache(_ entity: LocalNotificationEntity) -> LocalNotificationEntityCache {
        .init(
            id: entity.id,
            accountId: entity.accountId,
            title: entity.title,
            body: entity.body,
            datetime: entity.datetime,
            repeats: entity.repeats,
            createdAt: entity.createdAt,
            updatedAt: entity.updatedAt,
            isReaded: entity.isReaded
        )
    }
}
