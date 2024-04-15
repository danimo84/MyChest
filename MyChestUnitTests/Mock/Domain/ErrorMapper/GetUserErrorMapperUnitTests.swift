//
//  GetUserErrorMapperUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 8/4/24.
//

import XCTest
@testable import MyChest

final class GetUserErrorMapperUnitTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func test_map_invalidUrl() {
        // Given
        let error = DataError.invalidUrl
        
        // When
        let result = GetUserErrorMapper.map(error)
        
        // Then
        XCTAssertEqual(result, .undefined)
    }
    
    func test_map_encoding() {
        // Given
        let error = DataError.encoding
        
        // When
        let result = GetUserErrorMapper.map(error)
        
        // Then
        XCTAssertEqual(result, .undefined)
    }
    
    func test_map_decoding() {
        // Given
        let error = DataError.decoding
        
        // When
        let result = GetUserErrorMapper.map(error)
        
        // Then
        XCTAssertEqual(result, .decoding)
    }
    
    func test_map_unauthorized() {
        // Given
        let error = DataError.unauthorized
        
        // When
        let result = GetUserErrorMapper.map(error)
        
        // Then
        XCTAssertEqual(result, .unauthorized)
    }
    
    func test_map_forbidden() {
        // Given
        let error = DataError.forbidden
        
        // When
        let result = GetUserErrorMapper.map(error)
        
        // Then
        XCTAssertEqual(result, .forbidden)
    }
    
    func test_map_server() {
        // Given
        let error = DataError.server
        
        // When
        let result = GetUserErrorMapper.map(error)
        
        // Then
        XCTAssertEqual(result, .server)
    }
    
    func test_map_notFound() {
        // Given
        let error = DataError.notFound
        
        // When
        let result = GetUserErrorMapper.map(error)
        
        // Then
        XCTAssertEqual(result, .notFound)
    }
   
    func test_map_badRequest() {
        // Given
        let error = DataError.badRequest
        
        // When
        let result = GetUserErrorMapper.map(error)
        
        // Then
        XCTAssertEqual(result, .badRequest)
    }
    
    func test_map_unknown() {
        // Given
        let error = DataError.unknown
        
        // When
        let result = GetUserErrorMapper.map(error)
        
        // Then
        XCTAssertEqual(result, .undefined)
    }
}
