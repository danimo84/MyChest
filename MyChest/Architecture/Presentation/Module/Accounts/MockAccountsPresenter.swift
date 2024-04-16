//
//  MockAccountsPresenter.swift
//  MyChest
//
//  Created by Daniel Moraleda on 17/1/24.
//

import Foundation
import SwiftData

final class MockAccountsPresenter: AccountsPresenter {
    
    @Published var selectedAccount: Account?
    @Published var accounts: [Account] = []
    @Published var isAccountSheetPresented: Bool = false
    
    func deleteAccount(_ account: Account) {
        // Intentionally empty
    }
    
    func fetchAccounts() {
        // Intentionally empty
    }
    
    func checkPendingShowAccount() {
        // Intentionally empty
    }
    
    func onAppear() {
        // Intentionally empty
    }
}
