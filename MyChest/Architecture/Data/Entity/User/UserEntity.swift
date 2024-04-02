//
//  UserEntity.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct UserEntity: Entity {
    
    let id: UserIdEntity?
    let name: UsernameEntity?
    let email: String?
    let dob: UserDateOfBornEntity?
    let phone: String?
    let picture: UserAvatarEntity?
    let location: UserLocationEntity?
}

extension UserEntity {
    
    static func emptyUser() -> UserEntity {
        UserEntity(
            id: nil,
            name: nil,
            email: nil,
            dob: nil,
            phone: nil,
            picture: nil,
            location: nil
        )
    }
}
