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
    
    private let getAccountsInteractor: GetAccountsInteractor
    private let deleteAccountInteractor: DeleteAccountInteractor
    private let requestNotificationPermissionIfNeededInteractor: RequestNotificationPermissionIfNeededInteractor
    
    init(
        getAccountsInteractor: GetAccountsInteractor,
        deleteAccountInteractor: DeleteAccountInteractor,
        requestNotificationPermissionIfNeededInteractor: RequestNotificationPermissionIfNeededInteractor
    ) {
        self.getAccountsInteractor = getAccountsInteractor
        self.deleteAccountInteractor = deleteAccountInteractor
        self.requestNotificationPermissionIfNeededInteractor = requestNotificationPermissionIfNeededInteractor
        fetchAccounts()
    }
}

extension AccountsViewModelDefault: AccountsViewModel {
    
    func fetchAccounts() {
        Task { await getAccounts() }
    }
    
    func deleteAccount(_ account: Account) {
        Task { await removeAccountAndRefresh(accountId: account.id) }
    }
    
    func onAppear() {
        Task { await requestNotificationsPermissionIfneeded() }
        checkPendingShowAccount()
    }
}

private extension AccountsViewModelDefault {
    
    @MainActor
    func requestNotificationsPermissionIfneeded() async {
        await requestNotificationPermissionIfNeededInteractor.execute()
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

private extension AccountsViewModelDefault {
    
    @MainActor
    func getAccounts() async {
        do {
            accounts = try await getAccountsInteractor.execute().async()
        } catch(let error) {
            print("Error: \(error)")
        }
    }
    
    @MainActor 
    func removeAccountAndRefresh(accountId: String) async {
        do {
            accounts = try await deleteAccountInteractor.executeWithResults(withId: accountId).async()
        } catch(let error) {
            print("Error: \(error)")
        }
    }
}
