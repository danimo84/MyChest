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
    
    func isSaveButtonDisabled() -> Bool {
        true
    }
    
    func saveNewAccount() {
        // Intentionally empty
    }
    
    func deleteAccount() {
        // Intentionally empty
    }
}
