//
//  LinkMetadataUnitTest.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class LinkMetadataUnitTest: XCTestCase {

    // Class
    var model: LinkMetadata!

    override func setUp() {
        super.setUp()
        buildClass()
    }
    
    func test_not_nil() {
        XCTAssertNotNil(model.id)
        XCTAssertNotNil(model.title)
        XCTAssertNotNil(model.description)
        XCTAssertNotNil(model.url)
        XCTAssertNotNil(model.imageUrl)
    }
}

private extension LinkMetadataUnitTest {
    
    func buildClass() {
        model = .emtpy()
    }
}
