//
//  UserEntityMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct UserEntityMapper {
    
    static func map(_ cache: UserEntityCache) -> UserEntity {
        UserEntity(
            id: UserIdEntity(
                name: cache.id,
                value: ""
            ),
            name: UsernameEntity(
                title: cache.name,
                first: cache.first,
                last: cache.last
            ),
            email: cache.email,
            dob: UserDateOfBornEntity(date: cache.dateOfBorn),
            phone: cache.phone,
            picture: UserAvatarEntity(
                large: cache.picture,
                medium: nil,
                thumbnail: nil
            ),
            location: UserLocationEntity(
                street: UserLocationStreetEntity(
                    number: cache.number,
                    name: cache.street
                ),
                city: cache.city,
                state: cache.state,
                country: cache.country,
                postcode: cache.postcode,
                coordinates: UserLocationCoordinatesEntity(
                    latitude: cache.latitude,
                    longitude: cache.longitude
                )
            )
        )
    }
    
    static func mapToCache(_ entity: UserEntity) -> UserEntityCache {
        UserEntityCache(
            id: entity.id?.id ?? UUID().uuidString,
            name: entity.name?.title ?? "",
            first: entity.name?.first ?? "",
            last: entity.name?.last ?? "",
            email: entity.email ?? "",
            dateOfBorn: entity.dob?.date ?? "",
            phone: entity.phone ?? "",
            picture: entity.picture?.medium ?? "",
            street: entity.location?.street?.name ?? "",
            number: entity.location?.street?.number ?? .zero,
            city: entity.location?.city ?? "",
            state: entity.location?.state ?? "",
            country: entity.location?.country ?? "",
            postcode: entity.location?.postcode ?? .zero,
            latitude: entity.location?.coordinates?.latitude ?? "",
            longitude: entity.location?.coordinates?.longitude ?? ""
        )
    }
}
