//
//  GetUserCoordinatesInteractorUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 14/4/24.
//

import XCTest
import SwiftyMocky
import Combine
@testable import MyChest

final class GetUserCoordinatesInteractorUnitTests: XCTestCase {

    // Class
    var entity: UserLocationCoordinatesEntity!
    var getLocationsInteractor: GetUserCoordinatesInteractorDefault!
    
    // Mock
    var geocoderRepository: GeocoderRepositoryMock!
    
    override func setUp() {
        super.setUp()
        buildMock()
        buildClass()
    }
    
    func test_execute_success() async {
        // Given
        let response = Just(entity!)
            .setFailureType(to: DataError.self)
            .eraseToAnyPublisher()
        Given(geocoderRepository, .getCoordinates(forAdress: Parameter(stringLiteral: "address"), willReturn: response))
        
        // When
        _ = getLocationsInteractor.execute(forAddress: "address")
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    // Then
                    XCTAssertEqual($0.latitude, UserCoordinateMapper.map(self.entity).latitude)
                    XCTAssertEqual($0.longitude, UserCoordinateMapper.map(self.entity).longitude)
                }
            )
    }
    
    func test_execute_failure_generic() async {
        // Given
        let response = Fail<UserLocationCoordinatesEntity, DataError>(error: DataError.forbidden)
            .eraseToAnyPublisher()
        Given(geocoderRepository, .getCoordinates(forAdress: "address", willReturn: response))
        
        // When
        _ = getLocationsInteractor.execute(forAddress: "address")
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        // Then
                        XCTAssertEqual(error, GetUserCoordinatesErrorMapper.map(DataError.forbidden))
                    }
                },
                receiveValue: { _ in }
            )
    }
}

private extension GetUserCoordinatesInteractorUnitTests {
    
    func buildMock() {
        geocoderRepository = GeocoderRepositoryMock()
    }
    
    func buildClass() {
        getLocationsInteractor = GetUserCoordinatesInteractorDefault(geocoderRepository: geocoderRepository)
        entity = UserLocationCoordinatesEntity(
            latitude: "0.0000",
            longitude: "-0.0000"
        )
    }
}
