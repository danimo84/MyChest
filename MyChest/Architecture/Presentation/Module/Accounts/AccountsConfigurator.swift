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
        
        let accountRepository = injector.instanceOf(AccountRepository.self)
        let notificationRepository = injector.instanceOf(LocalNotificationRepository.self)
        
        let viewModel = AccountsViewModelDefault(
            accountRepository: accountRepository,
            notificationRepository: notificationRepository
        )
        
        let view: some View = AccountsView<AccountsViewModelDefault>()
            .environmentObject(viewModel)
        
        return view
    }
}
