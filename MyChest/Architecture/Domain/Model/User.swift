//
//  User.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct User: ModelDefault {
    
    let id: String
    var username: Username
    var email: String
    var dateOfBorn: String
    var phone: String
    var avatar: String
    var location: UserLocation
}

extension User {
    
    static func mockUser() -> User {
        .init(
            id: UUID().uuidString,
            username: Username(
                id: UUID().uuidString,
                title: "Mr",
                first: "Alvaro",
                last: "Bravo"
            ),
            email: "alvaro.bravo@example.com",
            dateOfBorn: "1981-07-09T14:28:27.640Z",
            phone: "(693) 127 5994",
            avatar: "https://randomuser.me/api/portraits/med/men/71.jpg",
            location: UserLocation(
                id: UUID().uuidString,
                street: "Calle Cepeda",
                number: 908,
                city: "Tepojaco",
                state: "Campeche",
                country: "Mexico",
                postcode: 56856,
                latitude: "28.2672",
                longitude: "-96.6164"
            )
        )
    }
}
