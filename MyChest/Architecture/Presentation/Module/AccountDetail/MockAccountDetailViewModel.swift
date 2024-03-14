//
//  MockAccountDetailViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftData

final class MockAccountDetailViewModel: AccountDetailViewModel {
    
    var account: Account = .mock()
    var newAccount: Bool = false
    var isPasswordEditable: Bool = false
    var isPasswordSecured: Bool = false
    var config: Config = .defaultConfig()
    var isSaveButtonDisabled: Bool = false
    
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
    
    func paswordUpdated() {
        // Intentionally empty
    }
}
