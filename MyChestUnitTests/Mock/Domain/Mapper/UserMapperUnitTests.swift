//
//  UserMapperUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class UserMapperUnitTests: XCTestCase {

    var userEntity: UserEntity!
    
    override func setUp() {
        super.setUp()
        buildClass()
    }
    
    func test_map_nil() {
        // Given
        let entity = UserEntity(
            id: nil,
            name: nil,
            email: nil,
            dob: nil,
            phone: nil,
            picture: nil,
            location: nil
        )
        
        // When
        let result = UserMapper.map(entity)
        
        // Then
        XCTAssertNotNil(result.id)
        XCTAssertNotNil(result.username)
        XCTAssertNotNil(result.email)
        XCTAssertNotNil(result.dateOfBorn)
        XCTAssertNotNil(result.phone)
        XCTAssertNotNil(result.avatar)
        XCTAssertNotNil(result.location)
    }
    
    func test_map_success() {
        // Given
        let entity = userEntity!
        
        // When
        let result = UserMapper.map(entity)
        
        // Then
        XCTAssertEqual(result.username.title, "usernametitle")
        XCTAssertEqual(result.username.first, "usernamefirst")
        XCTAssertEqual(result.username.last, "usernamelast")
        XCTAssertEqual(result.email, "email")
        XCTAssertEqual(result.dateOfBorn, "13/02/2024")
        XCTAssertEqual(result.phone, "(111)111111")
        XCTAssertEqual(result.avatar, "large")
        XCTAssertEqual(result.location.street, "streetname")
        XCTAssertEqual(result.location.number, 1)
        XCTAssertEqual(result.location.city, "city")
        XCTAssertEqual(result.location.state, "state")
        XCTAssertEqual(result.location.country, "country")
        XCTAssertEqual(result.location.postcode, 12345)
        XCTAssertEqual(result.location.latitude, "1.32323")
        XCTAssertEqual(result.location.longitude, "-23.32323")
    }
    
    func test_map_failure() {
        // Given
        let entity = userEntity!
        
        // When
        let result = UserMapper.map(entity)
        
        // Then
        XCTAssertNotEqual(result.username.title, "fakestring")
        XCTAssertNotEqual(result.username.first, "fakestring")
        XCTAssertNotEqual(result.username.last, "fakestring")
        XCTAssertNotEqual(result.email, "fakestring")
        XCTAssertNotEqual(result.dateOfBorn, "fakestring")
        XCTAssertNotEqual(result.phone, "fakestring")
        XCTAssertNotEqual(result.avatar, "fakestring")
        XCTAssertNotEqual(result.location.street, "fakestring")
        XCTAssertNotEqual(result.location.number, 0)
        XCTAssertNotEqual(result.location.city, "fakestring")
        XCTAssertNotEqual(result.location.state, "fakestring")
        XCTAssertNotEqual(result.location.country, "fakestring")
        XCTAssertNotEqual(result.location.postcode, 0)
        XCTAssertNotEqual(result.location.latitude, "fakestring")
        XCTAssertNotEqual(result.location.longitude, "fakestring")
    }
}

private extension UserMapperUnitTests {
    
    func buildClass() {
        userEntity = UserEntity(
            id: UserIdEntity(
                name: "useridname",
                value: "useridnamevalue"
            ),
            name: UsernameEntity(
                title: "usernametitle",
                first: "usernamefirst",
                last: "usernamelast"
            ),
            email: "email",
            dob: UserDateOfBornEntity(
                date: "13/02/2024"
            ),
            phone: "(111)111111",
            picture: UserAvatarEntity(
                large: "large",
                medium: "medium",
                thumbnail: "thumbnail"
            ),
            location: UserLocationEntity(
                street: UserLocationStreetEntity(
                    number: 1,
                    name: "streetname"
                ),
                city: "city",
                state: "state",
                country: "country",
                postcode: 12345,
                coordinates: UserLocationCoordinatesEntity(
                    latitude: "1.32323",
                    longitude: "-23.32323"
                )
            )
        )
    }
}
