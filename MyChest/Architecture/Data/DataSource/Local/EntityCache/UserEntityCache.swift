//
//  UserEntityCache.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation
import SwiftData

@Model
class UserEntityCache {
    
    @Attribute(.unique) var id: String
    var name: String
    var first: String
    var last: String
    var email: String
    var dateOfBorn: String
    var phone: String
    var picture: String
    var street: String
    var number: Int
    var city: String
    var state: String
    var country: String
    var postcode: Int
    var latitude: String
    var longitude: String
    
    init(
        id: String,
        name: String,
        first: String,
        last: String,
        email: String,
        dateOfBorn: String,
        phone: String,
        picture: String,
        street: String,
        number: Int,
        city: String,
        state: String,
        country: String,
        postcode: Int,
        latitude: String,
        longitude: String
    ) {
        self.id = id
        self.name = name
        self.first = first
        self.last = last
        self.email = email
        self.dateOfBorn = dateOfBorn
        self.phone = phone
        self.picture = picture
        self.street = street
        self.number = number
        self.city = city
        self.state = state
        self.country = country
        self.postcode = postcode
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension UserEntityCache {
    
    static func fetchUser(using context: ModelContext) -> UserEntityCache? {
        try? context.fetch(fetchDescriptor).first
    }
    
    static func insertUser(
        _ user: UserEntityCache,
        using context: ModelContext
    ) {
        context.insert(user)
        try? context.save()
    }
    
    static func updateUser(
        _ user: UserEntity,
        using context: ModelContext
    ) -> UserEntityCache? {
        defer { try? context.save() }
        return fetchOrCreate(
            user: user,
            using: context
        )
    }
    
    static func removeAll(using context: ModelContext) {
        deleteAll(using: context)
    }
}

private extension UserEntityCache {
    
    static var fetchDescriptor: FetchDescriptor<UserEntityCache> {
        .init()
    }
    
    static func fetchByIdDescriptor(_ id: String) -> FetchDescriptor<UserEntityCache> {
        .init(predicate: #Predicate { $0.id == id })
    }
    
    static func createCache(_ user: UserEntity) -> UserEntityCache {
        UserEntityMapper.mapToCache(user)
    }
    
    static func updateCache(
        _ cache: UserEntityCache,
        withNotification user: UserEntity
    ) -> UserEntityCache? {
        guard let userId = user.id?.id, userId == cache.id else {
            return nil
        }
        cache.id = userId
        cache.name = user.name?.first ?? ""
        cache.first = user.name?.first ?? ""
        cache.last = user.name?.last ?? ""
        cache.email = user.email ?? ""
        cache.dateOfBorn = user.dob?.date ?? ""
        cache.phone = user.phone ?? ""
        cache.picture = user.picture?.medium ?? ""
        cache.street = user.location?.street?.name ?? ""
        cache.number = user.location?.street?.number ?? .zero
        cache.city = user.location?.city ?? ""
        cache.state = user.location?.state ?? ""
        cache.country = user.location?.country ?? ""
        cache.postcode = user.location?.postcode ?? .zero
        cache.latitude = user.location?.coordinates?.latitude ?? ""
        cache.longitude = user.location?.coordinates?.longitude ?? ""
        
        return cache
    }
    
    static func fetchOrCreate(
        user: UserEntity,
        using context: ModelContext
    ) -> UserEntityCache? {
        guard let userId = user.id?.id else {
            return nil
        }
        if let userCache = (try? context.fetch(fetchByIdDescriptor(userId)))?.first {
            return updateCache(userCache, withNotification: user)
        }
        return createCache(user)
    }
    
    static func deleteAll(using context: ModelContext) {
        try? context.delete(model: UserEntityCache.self)
    }
}
