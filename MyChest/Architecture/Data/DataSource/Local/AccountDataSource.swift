//
//  AccountLocalDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 23/1/24.
//

import Foundation
import SwiftData

protocol AccountLocalDataSource {
    func fetchAccounts() -> [Account]
    func inserAccount(_ account: Account)
    func removeAccount(_ account: Account)
    func removeAllAccounts()
}

final class AccountLocalDataSourceDefault {
    
    private let databaseManager = DatabaseManager.shared
    
    init() {
        
    }
}

extension AccountLocalDataSourceDefault: AccountLocalDataSource {
    
    func fetchAccounts() -> [Account] {
        do {
            return try databaseManager.modelContext.fetch(FetchDescriptor<Account>())
        } catch {
            print("Error fetching Accounts")
            return []
        }
    }
    
    func inserAccount(_ account: Account) {
        databaseManager.modelContext.insert(account)
        do {
            try databaseManager.modelContext.save()
        } catch {
            print("Error inserting Account: \(account)")
        }
    }
    
    func removeAccount(_ account: Account) {
        databaseManager.modelContext.delete(account)
    }
    
    func removeAllAccounts() {
        do {
            try databaseManager.modelContext.delete(model: Account.self)
        } catch {
            print("Error deleting all Accounts")
        }
    }
}
