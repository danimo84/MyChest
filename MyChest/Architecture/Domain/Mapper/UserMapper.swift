//
//  UserMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct UserMapper {
    
    static func map(_ entity: UserEntity) -> User {
        User(
            id: entity.id?.id ?? UUID().uuidString,
            username: Username(
                id: UUID().uuidString,
                title: entity.name?.title ?? "",
                first: entity.name?.first ?? "",
                last: entity.name?.last ?? ""
            ),
            email: entity.email ?? "",
            dateOfBorn: entity.dob?.date ?? "",
            phone: entity.phone ?? "",
            avatar: entity.picture?.large ?? "",
            location: UserLocation(
                id: UUID().uuidString,
                street: entity.location?.street?.name ?? "",
                number: entity.location?.street?.number ?? .zero,
                city: entity.location?.city ?? "",
                state: entity.location?.state ?? "",
                country: entity.location?.country ?? "",
                postcode: entity.location?.postcode ?? .zero,
                latitude: entity.location?.coordinates?.latitude ?? "",
                longitude: entity.location?.coordinates?.longitude ?? ""
            )
        )
    }
    
    static func mapToEntity(_ model: User) -> UserEntity {
        UserEntity(
            id: UserIdEntity(
                name: model.id,
                value: ""
            ),
            name: UsernameEntity(
                title: model.username.title,
                first: model.username.first,
                last: model.username.last
            ),
            email: model.email,
            dob: UserDateOfBornEntity(date: model.dateOfBorn),
            phone: model.phone,
            picture: UserAvatarEntity(
                large: nil,
                medium: model.avatar,
                thumbnail: nil
            ),
            location: UserLocationEntity(
                street: UserLocationStreetEntity(
                    number: model.location.number,
                    name: model.location.street
                ),
                city: model.location.city,
                state: model.location.state,
                country: model.location.country,
                postcode: model.location.postcode,
                coordinates: UserLocationCoordinatesEntity(
                    latitude: model.location.latitude,
                    longitude: model.location.longitude
                )
            )
        )
    }
}
