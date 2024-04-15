//
//  GetUserInteractorUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 14/4/24.
//

import XCTest
import SwiftyMocky
import Combine
@testable import MyChest

final class GetUserInteractorUnitTests: XCTestCase {

    // Class
    var entity: UserEntity!
    var getUserInteractor: GetUserInteractorDefault!
    
    // Mock
    var userRepository: UserRepositoryMock!
    
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
        Given(userRepository, .getUser(willReturn: response))
        
        // When
        _ = getUserInteractor.execute()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    let mappedEntity = UserMapper.map(self.entity)
                    // Then
                    XCTAssertEqual($0.username.title, mappedEntity.username.title)
                    XCTAssertEqual($0.username.first, mappedEntity.username.first)
                    XCTAssertEqual($0.username.last, mappedEntity.username.last)
                    XCTAssertEqual($0.email, mappedEntity.email)
                    XCTAssertEqual($0.phone, mappedEntity.phone)
                    XCTAssertEqual($0.username.last, mappedEntity.username.last)
                    XCTAssertEqual($0.avatar, mappedEntity.avatar)
                    XCTAssertEqual($0.location.street, mappedEntity.location.street)
                }
            )
    }
    
    func test_execute_failure_generic() async {
        // Given
        let response = Fail<UserEntity, DataError>(error: DataError.forbidden)
            .eraseToAnyPublisher()
        Given(userRepository, .getUser(willReturn: response))
        
        // When
        _ = getUserInteractor.execute()
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        // Then
                        XCTAssertEqual(error, GetUserErrorMapper.map(DataError.forbidden))
                    }
                },
                receiveValue: { _ in }
            )
    }
}

private extension GetUserInteractorUnitTests {
    
    func buildMock() {
        userRepository = UserRepositoryMock()
    }
    
    func buildClass() {
        getUserInteractor = GetUserInteractorDefault(userRepository: userRepository)
        entity = UserEntity(
            id: UserIdEntity(
                name: "123",
                value: "AA"
            ),
            name: UsernameEntity(
                title: "title",
                first: "first",
                last: "last"
            ),
            email: "email",
            dob: UserDateOfBornEntity(date: "17/03/85"),
            phone: "phone",
            picture: UserAvatarEntity(
                large: "large",
                medium: "medium",
                thumbnail: "thumbnail"
            ),
            location: UserLocationEntity(
                street: UserLocationStreetEntity(
                    number: 1,
                    name: "street"
                ),
                city: "city",
                state: "state",
                country: "country",
                postcode: 12121,
                coordinates: UserLocationCoordinatesEntity(
                    latitude: "-1.22",
                    longitude: "1.23"
                )
            )
        )
    }
}
