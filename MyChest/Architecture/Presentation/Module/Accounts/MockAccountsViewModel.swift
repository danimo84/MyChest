//
//  MockAccountsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 17/1/24.
//

import Foundation
import SwiftData

final class MockAccountsViewModel: AccountsViewModel {

    var selectedAccount: Account?
    var accounts: [Account] = Account.mockList()
    
    func deleteAccount(_ account: Account) {
        // Intentionally empty
    }
    
    func fetchAccounts() {
        // Intentionally empty
    }
}
