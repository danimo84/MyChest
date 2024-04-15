//
//  LocalNotificationMapperUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class LocalNotificationMapperUnitTests: XCTestCase {

    let successDate: Date = Date(timeIntervalSinceReferenceDate: -123456789.0)
    let failureDate: Date = Date(timeIntervalSinceReferenceDate: -123456788.0)
    var notificationEntity: LocalNotificationEntity!
    
    override func setUp() {
        super.setUp()
        buildClass()
    }

    func test_map_success() {
        // Given
        let entity = notificationEntity!
        
        // When
        let result = LocalNotificationMapper.map(entity)
        
        // Then
        XCTAssertEqual(result.id, "0000-0000-0000")
        XCTAssertEqual(result.accountId, "0000-0000-0000")
        XCTAssertEqual(result.title, "Remember password")
        XCTAssertEqual(result.body, "Update your password")
        XCTAssertEqual(result.datetime, successDate)
        XCTAssertEqual(result.repeats, false)
        XCTAssertEqual(result.createdAt, successDate)
        XCTAssertEqual(result.updatedAt, successDate)
        XCTAssertEqual(result.isReaded, false)
    }
    
    func test_map_failure() {
        // Given
        let entity = notificationEntity!
        
        // When
        let result = LocalNotificationMapper.map(entity)
        
        // Then
        XCTAssertNotEqual(result.id, "")
        XCTAssertNotEqual(result.accountId, "")
        XCTAssertNotEqual(result.title, "fake_title")
        XCTAssertNotEqual(result.body, "fake_desc")
        XCTAssertNotEqual(result.datetime, failureDate)
        XCTAssertNotEqual(result.repeats, true)
        XCTAssertNotEqual(result.createdAt, failureDate)
        XCTAssertNotEqual(result.updatedAt, failureDate)
        XCTAssertNotEqual(result.isReaded, true)
    }
}

private extension LocalNotificationMapperUnitTests {
    
    func buildClass() {
        notificationEntity = LocalNotificationEntity(
            id: "0000-0000-0000",
            accountId: "0000-0000-0000",
            title: "Remember password",
            body: "Update your password",
            datetime: successDate,
            repeats: false,
            createdAt: successDate,
            updatedAt: successDate,
            isReaded: false
        )
    }
}
