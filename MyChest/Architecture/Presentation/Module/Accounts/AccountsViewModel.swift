//
//  AccountsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 17/1/24.
//

import Foundation
import Combine

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
    
    private var subscriptions = Set<AnyCancellable>()
    
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
        accountRepository.fetchAccounts()
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Error: \(error)")
                    }
                },
                receiveValue: {
                    self.accounts = $0
                }
            )
            .store(in: &subscriptions)
    }
    
    func deleteAccount(_ account: Account) {
        accountRepository.removeAccount(withId: account.id)
        notificationRepository.removeNotificationsWithAccountId(account.id)
        fetchAccounts()
    }
    
    func onAppear() {
        Task { await requestNotificationsPermissionIfneeded() }
        checkPendingShowAccount()
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
