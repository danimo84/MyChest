//
//  GetLocalNotificationInteractorUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 14/4/24.
//

import XCTest
import SwiftyMocky
import Combine
@testable import MyChest

final class GetLocalNotificationInteractorUnitTests: XCTestCase {

    let testDate: Date = Date(timeIntervalSinceReferenceDate: -123456789.0)
    
    // Class
    var entity: LocalNotificationEntity!
    var getNotificationInteractor: GetLocalNotificationInteractorDefault!
    
    // Mock
    var notificationRepository: LocalNotificationRepositoryMock!
    
    override func setUp() {
        super.setUp()
        buildMocks()
        buildClass()
    }
    
    func test_execute_success() async {
        // Given
        let response = Just([entity!])
            .setFailureType(to: DataError.self)
            .eraseToAnyPublisher()
        Given(notificationRepository, .fetchNotifications(willReturn: response))
        
        // When
        _ = getNotificationInteractor.execute()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    // Then
                    XCTAssertEqual($0.first!, LocalNotificationMapper.map(self.entity))
                }
            )
    }
    
    func test_execute_failure_generic() async {
        // Given
        let response = Fail<[LocalNotificationEntity], DataError>(error: DataError.forbidden)
            .eraseToAnyPublisher()
        Given(notificationRepository, .fetchNotifications(willReturn: response))
        
        // When
        _ = getNotificationInteractor.execute()
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        // Then
                        XCTAssertEqual(error, GetLocalNotificationErrorMapper.map(DataError.forbidden))
                    }
                },
                receiveValue: { _ in }
            )
    }
}

private extension GetLocalNotificationInteractorUnitTests {
    
    func buildMocks() {
        notificationRepository = LocalNotificationRepositoryMock()
    }
    
    func buildClass() {
        getNotificationInteractor = GetLocalNotificationInteractorDefault(notificationRepository: notificationRepository)
        entity = LocalNotificationEntity(
            id: "0000-1111",
            accountId: "accountId",
            title: "title",
            body: "body",
            datetime: testDate,
            repeats: false,
            createdAt: testDate,
            updatedAt: testDate,
            isReaded: false
        )
    }
}
