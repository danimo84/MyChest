//
//  GetAccountsInteractorUnitTests.swift
//  MyChestUnitTests
//
//  Created by Daniel Moraleda on 9/4/24.
//

import XCTest
import Combine
import SwiftyMocky
@testable import MyChest

final class GetAccountsInteractorUnitTests: XCTestCase {
    
    let successDate: Date = Date(timeIntervalSinceReferenceDate: -123456789.0)
    
    // Class
    var entity: AccountEntity!
    var getAccountsInteractor: GetAccountsInteractorDefault!
    
    // Mock
    var accountRepository: AccountRepositoryMock!
    
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
        Given(accountRepository, .fetchAccounts(willReturn: response))
        
        // When
        _ = getAccountsInteractor.execute()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {
                    // Then
                    XCTAssertEqual($0.first!, AccountMapper.map(self.entity))
                }
            )
    }
    
    func test_execute_failure_generic() async {
        // Given
        let response = Fail<[AccountEntity], DataError>(error: DataError.forbidden)
            .eraseToAnyPublisher()
        Given(accountRepository, .fetchAccounts(willReturn: response))
        
        // When
        _ = getAccountsInteractor.execute()
            .sink(
                receiveCompletion: {
                    switch $0 {
                    case .finished:
                        break
                    case .failure(let error):
                        // Then
                        XCTAssertEqual(error, GetAccountsErrorMapper.map(DataError.forbidden))
                    }
                },
                receiveValue: { _ in }
            )
    }
}

private extension GetAccountsInteractorUnitTests {
    
    func buildMocks() {
        accountRepository = AccountRepositoryMock()
    }
    
    func buildClass() {
        getAccountsInteractor = GetAccountsInteractorDefault(accountRepository: accountRepository)
        entity = AccountEntity(
            id: "0000-1111",
            user: "user",
            password: "password",
            domain: "domain.com",
            domainProtocol: "https://",
            image: "image",
            comment: "comment",
            rememberUpdateMonths: 1,
            createdAt: successDate,
            updatedAt: successDate
        )
    }
}
