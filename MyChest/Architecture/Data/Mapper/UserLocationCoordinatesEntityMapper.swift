//
//  UserLocationCoordinatesEntityMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/4/24.
//

import Foundation
import CoreLocation

struct UserLocationCoordinatesEntityMapper {
    
    static func map(_ placemark: CLPlacemark) -> UserLocationCoordinatesEntity {
        UserLocationCoordinatesEntity(
            latitude: String(placemark.location?.coordinate.latitude ?? .zero),
            longitude: String(placemark.location?.coordinate.longitude ?? .zero)
        )
    }
}
