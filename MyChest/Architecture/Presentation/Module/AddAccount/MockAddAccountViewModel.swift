//
//  MockAddAccountViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftData

final class MockAddAccountViewModel: AddAccountViewModel {
    
    var account: Account = .mock()
    var newAccount: Bool = false
    var config: Config = .defaultConfig()
    
    func isSaveButtonDisabled() -> Bool {
        true
    }
    
    func saveNewAccount() {
        // Intentionally empty
    }
    
    func deleteAccount() {
        // Intentionally empty
    }
    
    func fetchConfig() {
        // Intentionally empty
    }
    
    func generatePassword() {
        // Intentionally empty
    }
}
