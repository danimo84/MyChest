//
//  ConfigUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class ConfigUnitTests: XCTestCase {
    
    // Class
    var model: Config!
    
    override func setUp() {
        super.setUp()
        buildClass()
    }
    
    func test_not_nil() {
        XCTAssertNotNil(model.id)
        XCTAssertNotNil(model.charactersNumber)
        XCTAssertNotNil(model.requireUpper)
        XCTAssertNotNil(model.requireLower)
        XCTAssertNotNil(model.requireNumber)
        XCTAssertNotNil(model.requireSpecialCharacter)
        XCTAssertNotNil(model.storeInKeyChain)
        XCTAssertNotNil(model.areNotificationsEnabled)
    }
}

private extension ConfigUnitTests {
    
    func buildClass() {
        model = .defaultConfig()
    }
}
