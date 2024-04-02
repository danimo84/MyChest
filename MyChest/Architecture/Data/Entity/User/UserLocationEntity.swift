//
//  UserLocationEntity.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct UserLocationEntity: Entity {
    
    let street: UserLocationStreetEntity?
    let city: String?
    let state: String?
    let country: String?
    let postcode: Int?
    let coordinates: UserLocationCoordinatesEntity?
}
