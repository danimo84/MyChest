//
//  GetConfigInteractorUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 11/4/24.
//

import XCTest
import SwiftyMocky
import Combine
@testable import MyChest

final class GetConfigInteractorUnitTests: XCTestCase {

    // Class
    var configEntity: ConfigEntity!
    var getConfigInteractor: GetConfigInteractorDefault!
    
    // Mock
    var configRepository: ConfigRepositoryMock!
    
    override func setUp() {
        super.setUp()
        buildMocks()
        buildClass()
    }
    
    func test_execute_success() async {
        // Given
        let response = Just(configEntity!)
            .setFailureType(to: DataError.self)
            .eraseToAnyPublisher()
        Given(configRepository, .fetchConfig(willReturn: response))
        
        // When
        _ = getConfigInteractor.execute()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    // Then
                    XCTAssertEqual($0, ConfigMapper.map(self.configEntity))
                })
    }
    
    func test_execute_failure_generic() async {
        // Given
        let response = Fail<ConfigEntity, DataError>(error: .forbidden)
            .eraseToAnyPublisher()
        Given(configRepository, .fetchConfig(willReturn: response))
        
        // When
        _ = getConfigInteractor.execute()
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        // Then
                        XCTAssertEqual(error, GetConfigErrorMapper.map(.forbidden))
                    }
                }, receiveValue: { _ in }
            )
    }
}

private extension GetConfigInteractorUnitTests {
    
    func buildMocks() {
        configRepository = ConfigRepositoryMock()
    }
    
    func buildClass() {
        getConfigInteractor = GetConfigInteractorDefault(configRepository: configRepository)
        configEntity = ConfigEntity(
            id: "0000-1111",
            charactersNumber: 16,
            requireUpper: true,
            requireLower: true,
            requireNumber: true,
            requireSpecialCharacter: true,
            storeInKeyChain: false,
            areNotificationsEnabled: true
        )
    }
}
