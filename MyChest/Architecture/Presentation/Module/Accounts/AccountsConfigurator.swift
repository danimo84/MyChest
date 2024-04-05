//
//  AccountsConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 17/1/24.
//

import SwiftUI

struct AccountsConfigurator {
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    func view() -> some View {
        
        let getAccountsInteractor = injector.instanceOf(GetAccountsInteractor.self)
        let deleteAccountInteractor = injector.instanceOf(DeleteAccountInteractor.self)
        let requestNotificationPermissionIfNeededInteractor = injector.instanceOf(RequestNotificationPermissionIfNeededInteractor.self)
        
        let viewModel = AccountsViewModelDefault(
            getAccountsInteractor: getAccountsInteractor,
            deleteAccountInteractor: deleteAccountInteractor,
            requestNotificationPermissionIfNeededInteractor: requestNotificationPermissionIfNeededInteractor
        )
        
        let view: some View = AccountsView<AccountsViewModelDefault>(viewModel: viewModel)
        
        return view
    }
}
