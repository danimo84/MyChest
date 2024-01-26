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
    
    func isSaveButtonDisabled() -> Bool
    func saveNewAccount()
    func deleteAccount()
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
    
    @ObservationIgnored
    private let accountRepository: AccountRepository
    
    init(
        originalAccount: Account?,
        accountRepository: AccountRepository
    ) {
        if let originalAccount {
            account = originalAccount
        }
        newAccount = originalAccount == nil ? true : false
        self.accountRepository = accountRepository
    }
    
    func isSaveButtonDisabled() -> Bool {
        account.domain.isEmpty || account.user.isEmpty || account.password.isEmpty
    }
    
    func saveNewAccount() {
        accountRepository.inserAccount(account)
//        guard newAccount else {
//            return
//        }
//        modelContext.insert(account)
    }
    
    func deleteAccount() {
        accountRepository.removeAccount(account)
//        modelContext.delete(account)
    }
}

private extension AddAccountViewModelDefault {
    
}
