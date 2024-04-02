//
//  UserLocation.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct UserLocation: ModelDefault {
    
    var id: String
    var street: String
    var number: Int
    var city: String
    var state: String
    var country: String
    var postcode: Int
    var latitude: String
    var longitude: String
}
