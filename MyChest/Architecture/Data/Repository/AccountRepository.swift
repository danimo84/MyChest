//
//  AccountRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 23/1/24.
//

import Foundation

protocol AccountRepository {
    func fetchAccounts() -> [Account]
    func inserAccount(_ account: Account)
    func removeAccount(_ account: Account)
    func removeAllAccounts()
}

final class AccountRepositoryDefault {
    
    private let localDataSource: AccountLocalDataSource
    
    init(localDataSource: AccountLocalDataSource) {
        self.localDataSource = localDataSource
    }
}

extension AccountRepositoryDefault: AccountRepository {
    
    func fetchAccounts() -> [Account] {
        localDataSource.fetchAccounts()
    }
    
    func inserAccount(_ account: Account) {
        localDataSource.inserAccount(account)
    }
    
    func removeAccount(_ account: Account) {
        localDataSource.removeAccount(account)
    }
    
    func removeAllAccounts() {
        localDataSource.removeAllAccounts()
    }
}
