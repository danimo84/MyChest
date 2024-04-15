//
//  UserCoordinateMapperUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class UserCoordinateMapperUnitTests: XCTestCase {

    var coordinatesEntity: UserLocationCoordinatesEntity!
    
    override func setUp() {
        super.setUp()
        buildClass()
    }
    
    func test_map_nil() {
        // Given
        let entity = UserLocationCoordinatesEntity(
            latitude: nil,
            longitude: nil
        )
        
        // When
        let result = UserCoordinateMapper.map(entity)
        
        // Then
        XCTAssertEqual(result.latitude, "")
        XCTAssertEqual(result.longitude, "")
    }
    
    func test_map_success() {
        // Given
        let entity = coordinatesEntity!
        
        // When
        let result = UserCoordinateMapper.map(entity)
        
        // Then
        XCTAssertEqual(result.latitude, "1.32323")
        XCTAssertEqual(result.longitude, "-23.32323")
    }
    
    func test_map_failure() {
        // Given
        let entity = coordinatesEntity!
        
        // When
        let result = UserCoordinateMapper.map(entity)
        
        // Then
        XCTAssertNotEqual(result.latitude, "fake_string")
        XCTAssertNotEqual(result.longitude, "fake_string")
    }
}

private extension UserCoordinateMapperUnitTests {
    
    func buildClass() {
        coordinatesEntity = UserLocationCoordinatesEntity(
            latitude: "1.32323",
            longitude: "-23.32323"
        )
    }
}
