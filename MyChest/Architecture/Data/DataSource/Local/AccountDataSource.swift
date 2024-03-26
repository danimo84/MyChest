//
//  AccountLocalDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 23/1/24.
//

import Foundation
import Combine

protocol AccountLocalDataSource {
    func fetchAccounts() -> AnyPublisher<[AccountEntity], DataError>
    func inserAccount(_ account: AccountEntity)
    func updateAccount(_ account: AccountEntity)
    func removeAccount(withId accountId: String)
    func removeAllAccounts()
}

final class AccountLocalDataSourceDefault {
    
    private let databaseManager = DatabaseManager.shared
    
    init() { }
}

extension AccountLocalDataSourceDefault: AccountLocalDataSource {
    
    func fetchAccounts() -> AnyPublisher<[AccountEntity], DataError> {
        Just(
            AccountEntityCache.fetchAccounts(using: databaseManager.modelContext)
        )
        .setFailureType(to: DataError.self)
        .map{ $0.map { AccountEntityMapper.map($0) } }
        .eraseToAnyPublisher()
    }
    
    func inserAccount(_ account: AccountEntity) {
        AccountEntityCache.insertNotification(
            AccountEntityMapper.mapToCache(account),
            using: databaseManager.modelContext
        )
    }
    
    func updateAccount(_ account: AccountEntity) {
        _ = AccountEntityCache.updateAccount(
            account,
            using: databaseManager.modelContext
        )
    }
    
    func removeAccount(withId accountId: String) {
        AccountEntityCache.removeAccount(
            withId: accountId,
            using: databaseManager.modelContext
        )
    }
    
    func removeAllAccounts() {
        AccountEntityCache.removeAllAccounts(using: databaseManager.modelContext)
    }
}
