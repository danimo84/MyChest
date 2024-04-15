//
//  ConfigMapperUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class ConfigMapperUnitTests: XCTestCase {

    var configEntity: ConfigEntity!
    
    override func setUp() {
        super.setUp()
        buildClass()
    }
    
    func test_map_success() {
        // Given
        let entity = configEntity!
        
        // When
        let result = ConfigMapper.map(entity)
        
        // Then
        XCTAssertEqual(result.id, "0000-0000-0000")
        XCTAssertEqual(result.charactersNumber, 16)
        XCTAssertEqual(result.requireUpper, true)
        XCTAssertEqual(result.requireLower, true)
        XCTAssertEqual(result.requireNumber, true)
        XCTAssertEqual(result.requireSpecialCharacter, true)
        XCTAssertEqual(result.storeInKeyChain, false)
        XCTAssertEqual(result.areNotificationsEnabled, true)
    }
    
    func test_map_failure() {
        // Given
        let entity = configEntity!
        
        // When
        let result = ConfigMapper.map(entity)
        
        // Then
        XCTAssertNotEqual(result.id, "fake_id")
        XCTAssertNotEqual(result.charactersNumber, 0)
        XCTAssertNotEqual(result.requireUpper, false)
        XCTAssertNotEqual(result.requireLower, false)
        XCTAssertNotEqual(result.requireNumber, false)
        XCTAssertNotEqual(result.requireSpecialCharacter, false)
        XCTAssertNotEqual(result.storeInKeyChain, true)
        XCTAssertNotEqual(result.areNotificationsEnabled, false)
    }
}

extension ConfigMapperUnitTests {
    
    func buildClass() {
        configEntity = ConfigEntity(
            id: "0000-0000-0000",
            charactersNumber: 16,
            requireUpper: true,
            requireLower: true,
            requireNumber: true,
            requireSpecialCharacter: true,
            storeInKeyChain: false,
            areNotificationsEnabled: true
        )
    }
}
