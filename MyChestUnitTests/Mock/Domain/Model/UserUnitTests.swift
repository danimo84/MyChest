//
//  UserUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class UserUnitTests: XCTestCase {

    // Class
    var model: User!
    
    override func setUp() {
        super.setUp()
        buildClass()
    }
    
    func test_not_nil() {
        XCTAssertNotNil(model.id)
        XCTAssertNotNil(model.username)
        XCTAssertNotNil(model.username.id)
        XCTAssertNotNil(model.username.title)
        XCTAssertNotNil(model.username.first)
        XCTAssertNotNil(model.username.last)
        XCTAssertNotNil(model.email)
        XCTAssertNotNil(model.dateOfBorn)
        XCTAssertNotNil(model.phone)
        XCTAssertNotNil(model.avatar)
        XCTAssertNotNil(model.location)
        XCTAssertNotNil(model.location.id)
        XCTAssertNotNil(model.location.street)
        XCTAssertNotNil(model.location.number)
        XCTAssertNotNil(model.location.city)
        XCTAssertNotNil(model.location.state)
        XCTAssertNotNil(model.location.country)
        XCTAssertNotNil(model.location.postcode)
        XCTAssertNotNil(model.location.latitude)
        XCTAssertNotNil(model.location.longitude)
    }
}

private extension UserUnitTests {
    
    func buildClass() {
        model = .empty()
    }
}
