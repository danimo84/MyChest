//
//  UserCoordinateMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 30/3/24.
//

import Foundation

struct UserCoordinateMapper {
    
    static func map(_ entity: UserLocationCoordinatesEntity) -> UserCoordinates {
        UserCoordinates(
            latitude: entity.latitude ?? "",
            longitude: entity.longitude ?? ""
        )
    }
}
