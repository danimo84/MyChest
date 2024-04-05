//
//  DeleteAccountWithResultsInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/4/24.
//

import Combine

protocol DeleteAccountInteractor {
    func executeWithResults(withId accountId: String) -> AnyPublisher<[Account], DeleteAccountError>
    func execute(withId accountId: String)
}

final class DeleteAccountInteractorDefault {
    
    private let accountRepository: AccountRepository
    private let notificationRepository: LocalNotificationRepository
    
    init(
        accountRepository: AccountRepository,
        notificationRepository: LocalNotificationRepository
    ) {
        self.accountRepository = accountRepository
        self.notificationRepository = notificationRepository
    }
}

extension DeleteAccountInteractorDefault: DeleteAccountInteractor {
    
    func executeWithResults(withId accountId: String) -> AnyPublisher<[Account], DeleteAccountError> {
        accountRepository.removeAccount(withId: accountId)
        notificationRepository.removeNotificationsWithAccountId(accountId)
        return accountRepository.fetchAccounts()
            .map {
                $0.map { AccountMapper.map($0) }
                    .sorted { $0.domain < $1.domain }
            }
            .mapError { DeleteAccountErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    func execute(withId accountId: String) {
        accountRepository.removeAccount(withId: accountId)
        notificationRepository.removeNotificationsWithAccountId(accountId)
    }
}
