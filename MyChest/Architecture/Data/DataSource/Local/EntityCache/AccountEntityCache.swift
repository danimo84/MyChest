//
//  AccountEntityCache.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftData

@Model
class AccountEntityCache: ModelDefault {
    
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
        id: String,
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
        self.id = id
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

extension AccountEntityCache {
    
    static func fetchAccounts(using context: ModelContext) -> [AccountEntityCache] {
        (try? context.fetch(fetchDescriptor)) ?? []
    }
    
    static func fetchAccount(
        withId id: String,
        using context: ModelContext
    ) -> AccountEntityCache? {
        (try? context.fetch(fetchByIdDescriptor(id)))?.first
    }
    
    static func insertNotification(
        _ account: AccountEntityCache,
        using context: ModelContext
    ) {
        context.insert(account)
        try? context.save()
    }
    
    static func updateAccount(
        _ account: AccountEntity,
        using context: ModelContext
    ) -> AccountEntityCache? {
        defer { try? context.save() }
        return fetchOrCreate(account: account, using: context)
    }
    
    static func removeAccount(
        withId id: String,
        using context: ModelContext
    ) {
        defer { try? context.save() }
        deleteAccount(withId: id, using: context)
    }
    
    static func removeAllAccounts(using context: ModelContext) {
        defer { try? context.save() }
        deleteAllAccounts(using: context)
    }
}

private extension AccountEntityCache {
    
    static var fetchDescriptor: FetchDescriptor<AccountEntityCache> {
        .init()
    }
    
    static func fetchByIdDescriptor(_ id: String) -> FetchDescriptor<AccountEntityCache> {
        .init(predicate: #Predicate {
            $0.id == id
        })
    }
    
    static func createCache(_ account: AccountEntity) -> AccountEntityCache {
        AccountEntityMapper.mapToCache(account)
    }
    
    static func updateCache(
        cache: AccountEntityCache,
        withAccount account: AccountEntity
    ) -> AccountEntityCache? {
        guard account.id == cache.id else {
            return nil
        }
        cache.id = account.id
        cache.user = account.user
        cache.password = account.password
        cache.domain = account.domain
        cache.domainProtocol = account.domainProtocol
        cache.image = account.image
        cache.comment = account.comment
        cache.rememberUpdateMonths = account.rememberUpdateMonths
        cache.createdAt = account.createdAt
        cache.updatedAt = account.updatedAt
        
        return cache
    }
    
    static func fetchOrCreate(
        account: AccountEntity,
        using context: ModelContext
    ) -> AccountEntityCache? {
        if let accountCache = (try? context.fetch(fetchByIdDescriptor(account.id)))?.first {
            return updateCache(cache: accountCache, withAccount: account)
        }
        return createCache(account)
    }
    
    static func deleteAccount(
        withId accountId: String,
        using context: ModelContext
    ) {
        try? context.delete(
            model: AccountEntityCache.self,
            where: #Predicate { $0.id == accountId }
        )
    }
    
    static func deleteAllAccounts(using context: ModelContext) {
        try? context.delete(model: AccountEntityCache.self)
    }
}
