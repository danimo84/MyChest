//
//  GetLinkMetadataInteractorUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 11/4/24.
//

import XCTest
import Combine
import SwiftyMocky
@testable import MyChest

final class GetLinkMetadataInteractorUnitTests: XCTestCase {
    
    // Class
    var linkMetadataEntity: LinkMetadataEntity!
    var getLinkMetadataInteractor: GetLinkMetadataInteractorDefault!
    
    // Mock
    var linkMetadataRepository: LinkMetadataRepositoryMock!
    
    override func setUp() {
        super.setUp()
        buildMocks()
        buildClass()
    }
    
    func test_execute_success() async {
        // Given
        let response = Just(linkMetadataEntity!)
            .setFailureType(to: DataError.self)
            .eraseToAnyPublisher()
        Given(linkMetadataRepository, .getLinkMetadata(forUrl: "url", willReturn: response))
        
        // When
        _ = getLinkMetadataInteractor.execute(forUrl: "url")
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    let entityMapped = LinkMetadataMapper.map(self.linkMetadataEntity)
                    // Then
                    XCTAssertEqual($0.title, entityMapped.title)
                    XCTAssertEqual($0.description, entityMapped.description)
                    XCTAssertEqual($0.url, entityMapped.url)
                    XCTAssertEqual($0.imageUrl, entityMapped.imageUrl)
                }
            )
    }
    
    func test_execute_failure_generic() async {
        // Given
        let response = Fail<LinkMetadataEntity, DataError>(error: DataError.forbidden)
            .eraseToAnyPublisher()
        Given(linkMetadataRepository, .getLinkMetadata(forUrl: "url", willReturn: response))
        
        // When
        _ = getLinkMetadataInteractor.execute(forUrl: "url")
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        // Then
                        XCTAssertEqual(error, GetLinkMetadataErrorMapper.map(DataError.forbidden))
                    }
                }, receiveValue: { _ in }
            )
    }
}

private extension GetLinkMetadataInteractorUnitTests {
    
    func buildMocks() {
        linkMetadataRepository = LinkMetadataRepositoryMock()
    }
    
    func buildClass() {
        getLinkMetadataInteractor = GetLinkMetadataInteractorDefault(linkMetadataRepository: linkMetadataRepository)
        linkMetadataEntity = LinkMetadataEntity(
            title: "title",
            description: "description",
            url: "url",
            imageUrl: "imageUrl"
        )
    }
}
