//
//  AccountUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class AccountUnitTests: XCTestCase {

    // Class
    var model: Account!

    override func setUp() {
        super.setUp()
        buildClass()
    }
    
    func test_not_nil() {
        XCTAssertNotNil(model.id)
        XCTAssertNotNil(model.user)
        XCTAssertNotNil(model.password)
        XCTAssertNotNil(model.domain)
        XCTAssertNotNil(model.domainProtocol)
        XCTAssertNotNil(model.image)
        XCTAssertNotNil(model.comment)
        XCTAssertNotNil(model.rememberUpdateMonths)
        XCTAssertNotNil(model.createdAt)
        XCTAssertNotNil(model.updatedAt)
    }
}

private extension AccountUnitTests {
    
    func buildClass() {
        model = .empty()
    }
}
