//
//  LocalNotificationMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/3/24.
//

import Foundation

struct LocalNotificationMapper {
    
    static func map(_ entity: LocalNotificationEntity) -> LocalNotification {
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
    
    static func mapToEntity(_ model: LocalNotification) -> LocalNotificationEntity {
        .init(
            id: model.id,
            accountId: model.accountId,
            title: model.title,
            body: model.body,
            datetime: model.datetime,
            repeats: model.repeats,
            createdAt: model.createdAt,
            updatedAt: model.updatedAt,
            isReaded: model.isReaded
        )
    }
}
