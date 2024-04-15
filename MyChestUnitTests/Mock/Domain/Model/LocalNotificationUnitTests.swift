//
//  LocalNotificationUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class LocalNotificationUnitTests: XCTestCase {

    // Class
    var emptyModel: LocalNotification!
    var modelFromEmptyAccount: LocalNotification!
    
    override func setUp() {
        super.setUp()
        buildClass()
    }
    
    func test_not_nil_from_empty_notification() {
        XCTAssertNotNil(emptyModel.id)
        XCTAssertNotNil(emptyModel.accountId)
        XCTAssertNotNil(emptyModel.title)
        XCTAssertNotNil(emptyModel.body)
        XCTAssertNotNil(emptyModel.datetime)
        XCTAssertNotNil(emptyModel.repeats)
        XCTAssertNotNil(emptyModel.createdAt)
        XCTAssertNotNil(emptyModel.updatedAt)
        XCTAssertNotNil(emptyModel.isReaded)
    }
    
    func test_not_nil_from_empty_account() {
        XCTAssertNotNil(modelFromEmptyAccount.id)
        XCTAssertNotNil(modelFromEmptyAccount.accountId)
        XCTAssertNotNil(modelFromEmptyAccount.title)
        XCTAssertNotNil(modelFromEmptyAccount.body)
        XCTAssertNotNil(modelFromEmptyAccount.datetime)
        XCTAssertNotNil(modelFromEmptyAccount.repeats)
        XCTAssertNotNil(modelFromEmptyAccount.createdAt)
        XCTAssertNotNil(modelFromEmptyAccount.updatedAt)
        XCTAssertNotNil(modelFromEmptyAccount.isReaded)
    }
}

private extension LocalNotificationUnitTests {
    
    func buildClass() {
        emptyModel = .empty()
        modelFromEmptyAccount = .buildLocalNotificationForAccount(.empty())
    }
}
