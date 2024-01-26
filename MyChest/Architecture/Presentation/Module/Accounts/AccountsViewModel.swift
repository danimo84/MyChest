//
//  AccountsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 17/1/24.
//

import Foundation
import SwiftData

protocol AccountsViewModel: ObservableObject {
    var selectedAccount: Account? { get set }
    var accounts: [Account] { get set }
    
    func fetchAccounts()
    func deleteAccount(/*modelContext: ModelContext,*/ _ account: Account)
}

final class AccountsViewModelDefault: AccountsViewModel {
    
    @Published var selectedAccount: Account?
    @Published var accounts: [Account] = []
    
    @ObservationIgnored
    private let accountRepository: AccountRepository
    
    init(accountRepository: AccountRepository) {
        self.accountRepository = accountRepository
        fetchAccounts()
    }
    
    func fetchAccounts() {
        accounts = accountRepository.fetchAccounts()
    }
    
    func deleteAccount(/*modelContext: ModelContext,*/ _ account: Account) {
        accountRepository.removeAccount(account)
        accounts = accountRepository.fetchAccounts()
        //modelContext.delete(account)
    }
}

private extension AccountsViewModelDefault {
    
}
