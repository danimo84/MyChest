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
        
        let viewModel = AddAccountViewModelDefault(
            originalAccount: originalAccount,
            accountRepository: accountRepository
        )
        
        let view: some View = AddAccountView<AddAccountViewModelDefault>(isPresented: isPresented)
            .environmentObject(viewModel)
        
        return view
    }
}
