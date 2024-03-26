//
//  AccountRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 23/1/24.
//

import Foundation
import Combine

protocol AccountRepository {
    func fetchAccounts() -> AnyPublisher<[Account], AccountError>
    func inserAccount(_ account: Account)
    func updateAccount(_ account: Account)
    func removeAccount(withId accountId: String)
    func removeAllAccounts()
}

final class AccountRepositoryDefault {
    
    private let localDataSource: AccountLocalDataSource
    
    init(localDataSource: AccountLocalDataSource) {
        self.localDataSource = localDataSource
    }
}

extension AccountRepositoryDefault: AccountRepository {
    
    func fetchAccounts() -> AnyPublisher<[Account], AccountError> {
        localDataSource.fetchAccounts()
            .map {
                $0.map { AccountMapper.map($0) }
                    .sorted { $0.domain < $1.domain }
            }
            .mapError {
                AccountErrorMapper.map($0)
            }
            .eraseToAnyPublisher()
    }
    
    func inserAccount(_ account: Account) {
        localDataSource.inserAccount(AccountMapper.mapToEntity(account))
    }
    
    func updateAccount(_ account: Account) {
        localDataSource.updateAccount(AccountMapper.mapToEntity(account))
    }
    
    func removeAccount(withId accountId: String) {
        localDataSource.removeAccount(withId: accountId)
    }
    
    func removeAllAccounts() {
        localDataSource.removeAllAccounts()
    }
}
