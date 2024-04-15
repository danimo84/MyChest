//
//  AccountMapperUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class AccountMapperUnitTests: XCTestCase {

    let successDate: Date = Date(timeIntervalSinceReferenceDate: -123456789.0)
    let failureDate: Date = Date(timeIntervalSinceReferenceDate: -123456788.0)
    var accountEntity: AccountEntity!

    override func setUp() {
        super.setUp()
        buildClass()
    }
    
    func test_map_success() {
        // Given
        let entity = accountEntity!
        
        // When
        let result = AccountMapper.map(entity)
        
        // Then
        XCTAssertEqual(result.id, "0000-0000-0000")
        XCTAssertEqual(result.user, "user")
        XCTAssertEqual(result.password, "password")
        XCTAssertEqual(result.domain, "domain.coom")
        XCTAssertEqual(result.domainProtocol, "https://")
        XCTAssertEqual(result.image, "image")
        XCTAssertEqual(result.comment, "comment")
        XCTAssertEqual(result.rememberUpdateMonths, 1)
        XCTAssertEqual(result.createdAt, successDate)
        XCTAssertEqual(result.updatedAt, successDate)
    }
    
    func test_map_failure() {
        // Given
        let entity = accountEntity!
        
        // When
        let result = AccountMapper.map(entity)
        
        // Then
        XCTAssertNotEqual(result.id, "")
        XCTAssertNotEqual(result.user, "fake_user")
        XCTAssertNotEqual(result.password, "fake_password")
        XCTAssertNotEqual(result.domain, "fake_domain.coom")
        XCTAssertNotEqual(result.domainProtocol, "fake_https://")
        XCTAssertNotEqual(result.image, "fake_image")
        XCTAssertNotEqual(result.comment, "fake_comment")
        XCTAssertNotEqual(result.rememberUpdateMonths, 2)
        XCTAssertNotEqual(result.createdAt, failureDate)
        XCTAssertNotEqual(result.updatedAt, failureDate)
    }
}

private extension AccountMapperUnitTests {
    
    func buildClass() {
        accountEntity = AccountEntity(
            id: "0000-0000-0000",
            user: "user",
            password: "password",
            domain: "domain.coom",
            domainProtocol: "https://",
            image: "image",
            comment: "comment",
            rememberUpdateMonths: 1,
            createdAt: successDate,
            updatedAt: successDate
        )
    }
}
