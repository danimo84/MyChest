//
//  LocalNotificationEntityCache.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import Foundation
import SwiftData

@Model
class LocalNotificationEntityCache {
    
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

extension LocalNotificationEntityCache {
    
    static func fetchNotifications(context: ModelContext) -> [LocalNotificationEntityCache] {
        (try? context.fetch(fetchDescriptor)) ?? []
    }
    
    static func fetchNotification(
        withId id: String,
        using context: ModelContext
    ) -> LocalNotificationEntityCache? {
        (try? context.fetch(fetchByIdDescriptor(id)))?.first
    }
    
    static func insertNotification(
        _ notification: LocalNotificationEntityCache,
        using context: ModelContext
    ) {
        context.insert(notification)
        try? context.save()
    }
    
    static func updateNotification(
        _ notification: LocalNotificationEntity,
        using context: ModelContext
    ) -> LocalNotificationEntityCache? {
        defer { try? context.save() }
        return fetchOrCreate(notification: notification, using: context)
    }
    
    static func removeNotification(
        withId id: String,
        using context: ModelContext
    ) {
        defer { try? context.save() }
        deleteNotification(withAccountId: id, using: context)
    }
    
    static func removePendingNotification(
        withId id: String,
        using context: ModelContext
    ) {
        defer { try? context.save() }
        deletePendingNotification(withAccountId: id, using: context)
    }
    
    static func removeAllNotifications(using context: ModelContext) {
        defer { try? context.save() }
        deleteAllNotifications(using: context)
    }
}

private extension LocalNotificationEntityCache {
    
    static var fetchDescriptor: FetchDescriptor<LocalNotificationEntityCache> {
        .init()
    }
    
    static func fetchByIdDescriptor(_ id: String) -> FetchDescriptor<LocalNotificationEntityCache> {
        .init(predicate: #Predicate { $0.id == id })
    }
    
    static func createCache(_ notification: LocalNotificationEntity) -> LocalNotificationEntityCache {
        LocalNotificationEntityMapper.mapToCache(notification)
    }
    
    static func updateCache(
        _ cache: LocalNotificationEntityCache,
        withNotification localNotification: LocalNotificationEntity
    ) -> LocalNotificationEntityCache? {
        guard localNotification.id == cache.id else {
            return nil
        }
        cache.accountId = localNotification.accountId
        cache.title = localNotification.title
        cache.body = localNotification.body
        cache.datetime = localNotification.datetime
        cache.repeats = localNotification.repeats
        cache.createdAt = localNotification.createdAt
        cache.updatedAt = localNotification.updatedAt
        cache.isReaded = localNotification.isReaded
        
        return cache
    }
    
    static func fetchOrCreate(
        notification: LocalNotificationEntity,
        using context: ModelContext
    ) -> LocalNotificationEntityCache? {
        if let notificationCache = (try? context.fetch(fetchByIdDescriptor(notification.id)))?.first {
            return updateCache(notificationCache, withNotification: notification)
        }
        return createCache(notification)
    }
    
    static func deleteNotification(
        withAccountId accountId: String,
        using context: ModelContext
    ) {
        try? context.delete(
            model: LocalNotificationEntityCache.self,
            where: #Predicate { $0.accountId == accountId }
        )
    }
    
    static func deletePendingNotification(
        withAccountId accountId: String,
        using context: ModelContext
    ) {
        let now: Date = .now
        try? context.delete(
            model: LocalNotificationEntityCache.self,
            where: #Predicate { $0.accountId == accountId && $0.datetime < now }
        )
    }
    
    static func deleteAllNotifications(using context: ModelContext) {
        try? context.delete(model: LocalNotificationEntityCache.self)
    }
}
