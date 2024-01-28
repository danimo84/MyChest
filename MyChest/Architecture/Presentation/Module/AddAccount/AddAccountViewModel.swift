//
//  AddAccountViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftData

protocol AddAccountViewModel: ObservableObject {
    var account: Account { get set }
    var newAccount: Bool { get set }
    var config: Config { get set }
    
    func isSaveButtonDisabled() -> Bool
    func saveNewAccount()
    func deleteAccount()
    func fetchConfig()
    func generatePassword()
}

final class AddAccountViewModelDefault: AddAccountViewModel {
    
    let maxCommentCharacters = Constants.Accounts.maxAccountCommentCharacters
    
    @Published var account: Account = .empty() {
        didSet {
            if account.comment.count > maxCommentCharacters {
                account.comment = String(account.comment.prefix(maxCommentCharacters))
            }
        }
    }
    
    @Published var newAccount: Bool = false
    @Published var config: Config = .defaultConfig()
    
    private let accountRepository: AccountRepository
    private let configRepository: ConfigRepository
    private let passordGenerator: PasswordGeneratorManager
    
    init(
        originalAccount: Account?,
        accountRepository: AccountRepository,
        configRepository: ConfigRepository,
        passordGenerator: PasswordGeneratorManager
    ) {
        if let originalAccount {
            account = originalAccount
        }
        newAccount = originalAccount == nil ? true : false
        self.accountRepository = accountRepository
        self.configRepository = configRepository
        self.passordGenerator = passordGenerator
        fetchConfig()
    }
    
    func isSaveButtonDisabled() -> Bool {
        account.domain.isEmpty || account.user.isEmpty || account.password.isEmpty
    }
    
    func saveNewAccount() {
        accountRepository.inserAccount(account)
    }
    
    func deleteAccount() {
        accountRepository.removeAccount(account)
    }
    
    func fetchConfig() {
        config = configRepository.fetchConfig()
    }
    
    func generatePassword() {
        account.password = passordGenerator.generatePasswordWithConfig(config)
    }
}

private extension AddAccountViewModelDefault {
    
}
