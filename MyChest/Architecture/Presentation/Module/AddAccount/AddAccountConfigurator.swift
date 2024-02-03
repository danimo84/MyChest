//
//  AddAccountConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import SwiftUI

struct AddAccountConfigurator {
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    func view(isPresented: Binding<Bool>, originalAccount: Account?) -> some View {
        
        let accountRepository = injector.instanceOf(AccountRepository.self)
        let configRepository = injector.instanceOf(ConfigRepository.self)
        let notificationRepository = injector.instanceOf(LocalNotificationRepository.self)
        let passwordGenerator = injector.instanceOf(PasswordGeneratorManager.self)
        let notificationsManager = injector.instanceOf(NotificationsManager.self)
        
        let viewModel = AddAccountViewModelDefault(
            originalAccount: originalAccount,
            accountRepository: accountRepository,
            configRepository: configRepository,
            notificationRepository: notificationRepository,
            passordGenerator: passwordGenerator,
            notificationsManager: notificationsManager
        )
        
        let view: some View = AddAccountView<AddAccountViewModelDefault>(isPresented: isPresented)
            .environmentObject(viewModel)
        
        return view
    }
}
