//
//  LocalNotificationEntity.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/3/24.
//

import Foundation

struct LocalNotificationEntity: Entity {
    
    let id: String
    let accountId: String
    let title: String
    let body: String
    let datetime: Date
    let repeats: Bool
    let createdAt: Date
    let updatedAt: Date
    let isReaded: Bool
}
