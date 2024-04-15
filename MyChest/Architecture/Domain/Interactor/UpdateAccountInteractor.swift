//
//  UpdateAccountInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/4/24.
//

import Combine

// sourcery: AutoMockable
protocol UpdateAccountInteractor {
    func execute(_ account: Account)
}

final class UpdateAccountInteractorDefault {
    
    private let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
    }
}

extension UpdateAccountInteractorDefault: UpdateAccountInteractor {
    
    func execute(_ account: Account) {
        accountRepository.updateAccount(AccountMapper.mapToEntity(account))
    }
}
