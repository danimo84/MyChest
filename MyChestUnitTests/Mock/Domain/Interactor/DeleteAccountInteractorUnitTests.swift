//
//  DeleteAccountInteractorUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 9/4/24.
//

import XCTest
import Combine
import SwiftyMocky
@testable import MyChest

final class DeleteAccountInteractorUnitTests: XCTestCase {

    let testDate: Date = Date(timeIntervalSinceReferenceDate: -123456789.0)
    
    // Class
    var notificationEntity: LocalNotificationEntity!
    var accountEntity: AccountEntity!
    var deleteAccountInteractor: DeleteAccountInteractorDefault!
    
    // Mock
    var notificationRepository: LocalNotificationRepositoryMock!
    var accountRepository: AccountRepositoryMock!
    
    override func setUp() {
        super.setUp()
        buildMocks()
        buildClass()
    }
    
    func test_execute_with_result_success() async {
        // Given
        let response = Just([accountEntity!])
            .setFailureType(to: DataError.self)
            .eraseToAnyPublisher()
        Given(accountRepository, .fetchAccounts(willReturn: response))
        
        // When
        _ = deleteAccountInteractor.executeWithResults(withId: "0000_1111")
            .sink(
                receiveCompletion: { _ in},
                receiveValue: {
                    // Then
                    XCTAssertEqual($0.first, AccountMapper.map(self.accountEntity))
                }
            )
    }
    
    func test_execute_with_result_failure_generic() async {
        // Given
        let response = Fail<[AccountEntity], DataError>(error: DataError.forbidden)
            .eraseToAnyPublisher()
        Given(accountRepository, .fetchAccounts(willReturn: response))
        
        // When
        _ = deleteAccountInteractor.executeWithResults(withId: "0000_1111")
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        // Then
                        XCTAssertEqual(error, DeleteAccountErrorMapper.map(DataError.forbidden))
                    }
                }, receiveValue: { _ in }
            )
    }
}

private extension DeleteAccountInteractorUnitTests {
    
    func buildMocks() {
        notificationRepository = LocalNotificationRepositoryMock()
        accountRepository = AccountRepositoryMock()
    }
    
    func buildClass() {
        deleteAccountInteractor = DeleteAccountInteractorDefault(
            accountRepository: accountRepository,
            notificationRepository: notificationRepository
        )
        accountEntity = AccountEntity(
            id: "0000_1111",
            user: "user",
            password: "password",
            domain: "domain",
            domainProtocol: "https://",
            image: "image",
            comment: "comments",
            rememberUpdateMonths: 1,
            createdAt: testDate,
            updatedAt: testDate
        )
    }
}
