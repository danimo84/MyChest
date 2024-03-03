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
    var isAccountSheetPresented: Bool { get set }
    
    func fetchAccounts()
    func deleteAccount(_ account: Account)
    func onAppear()
}

final class AccountsViewModelDefault {
    
    @Published var selectedAccount: Account?
    @Published var accounts: [Account] = []
    @Published var isAccountSheetPresented: Bool = false
    
    private let accountRepository: AccountRepository
    private let notificationRepository: LocalNotificationRepository
    
    init(
        accountRepository: AccountRepository,
        notificationRepository: LocalNotificationRepository
    ) {
        self.accountRepository = accountRepository
        self.notificationRepository = notificationRepository
        fetchAccounts()
    }
}

extension AccountsViewModelDefault: AccountsViewModel {
    
    func fetchAccounts() {
        accounts = accountRepository.fetchAccounts()
    }
    
    func deleteAccount(_ account: Account) {
        accountRepository.removeAccount(account)
        notificationRepository.removeNotificationsWithAccountId(account.id)
        accounts = accountRepository.fetchAccounts()
    }
    
    func onAppear() {
        Task { await requestNotificationsPermissionIfneeded() }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.checkPendingShowAccount() }
    }
}

private extension AccountsViewModelDefault {
    
    @MainActor
    func requestNotificationsPermissionIfneeded() {
        Task {
            let permission = await PermissionsManager.isPermissionGrantedAndRequested(forType: .notifications)
            StorageManager.shared.areNotificationsEnabled = permission.isAccepted
        }
    }
    
    func checkPendingShowAccount() {
        guard let accountIdToNavigate = Router.shared.checkPendingAccountNavigation(),
              let account = accounts.first(where: { $0.id == accountIdToNavigate } )
        else {
            return
        }
        selectedAccount = account
        isAccountSheetPresented = true
    }
}
