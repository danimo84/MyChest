//
//  LinkMetadataMapperUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class LinkMetadataMapperUnitTests: XCTestCase {

    var linkMetadataEntity: LinkMetadataEntity!

    override func setUp() {
        super.setUp()
        buildClass()
    }
    
    func test_map_nil() {
        // Given
        let entity = LinkMetadataEntity(
            title: nil,
            description: nil,
            url: nil,
            imageUrl: nil
        )
        
        // When
        let result = LinkMetadataMapper.map(entity)
        
        // Then
        XCTAssertNotNil(result.id)
        XCTAssertNotNil(result.title)
        XCTAssertNotNil(result.description)
        XCTAssertNotNil(result.url)
        XCTAssertNotNil(result.imageUrl)
    }
    
    func test_map_success() {
        // Given
        let entity = linkMetadataEntity!
        
        // When
        let result = LinkMetadataMapper.map(entity)
        
        // Then
        XCTAssertEqual(result.title, "Netflix")
        XCTAssertEqual(result.description, "Streaming platform for series, films and documentaries.")
        XCTAssertEqual(result.url, "https://www.netflix.com")
        XCTAssertEqual(result.imageUrl, "https://cdn.icon-icons.com/icons2/3053/PNG/512/netflix_macos_bigsur_icon_189917.png")
    }
    
    func test_map_failure() {
        // Given
        let entity = linkMetadataEntity!
        
        // When
        let result = LinkMetadataMapper.map(entity)
        
        // Then
        XCTAssertNotEqual(result.title, "faketitle")
        XCTAssertNotEqual(result.description, "fakedesc")
        XCTAssertNotEqual(result.url, "fakeurl")
        XCTAssertNotEqual(result.imageUrl, "fakeurl")
    }
}

private extension LinkMetadataMapperUnitTests {
    
    func buildClass() {
        linkMetadataEntity = LinkMetadataEntity(
            title: "Netflix",
            description: "Streaming platform for series, films and documentaries.",
            url: "https://www.netflix.com",
            imageUrl: "https://cdn.icon-icons.com/icons2/3053/PNG/512/netflix_macos_bigsur_icon_189917.png"
        )
    }
}
