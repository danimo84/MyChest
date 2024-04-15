//
//  AccountRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 23/1/24.
//

import Combine

// sourcery: AutoMockable
protocol AccountRepository {
    func fetchAccounts() -> AnyPublisher<[AccountEntity], DataError>
    func inserAccount(_ account: AccountEntity)
    func updateAccount(_ account: AccountEntity)
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
    
    func fetchAccounts() -> AnyPublisher<[AccountEntity], DataError> {
        localDataSource.fetchAccounts()
    }
    
    func inserAccount(_ account: AccountEntity) {
        localDataSource.inserAccount(account)
    }
    
    func updateAccount(_ account: AccountEntity) {
        localDataSource.updateAccount(account)
    }
    
    func removeAccount(withId accountId: String) {
        localDataSource.removeAccount(withId: accountId)
    }
    
    func removeAllAccounts() {
        localDataSource.removeAllAccounts()
    }
}
