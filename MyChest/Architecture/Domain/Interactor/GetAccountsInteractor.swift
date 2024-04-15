//
//  GetAccountsInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/4/24.
//

import Combine

// sourcery: AutoMockable
protocol GetAccountsInteractor {
    func execute() -> AnyPublisher<[Account], GetAccountsError>
}

final class GetAccountsInteractorDefault {
    
    private let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
    }
}

extension GetAccountsInteractorDefault: GetAccountsInteractor {
    
    func execute() -> AnyPublisher<[Account], GetAccountsError> {
        accountRepository.fetchAccounts()
            .map {
                $0.map { AccountMapper.map($0) }
                    .sorted { $0.domain < $1.domain }
            }
            .mapError { GetAccountsErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
}
