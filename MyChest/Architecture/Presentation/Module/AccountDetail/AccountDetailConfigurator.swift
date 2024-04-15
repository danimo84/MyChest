//
//  AccountDetailConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import SwiftUI

struct AccountDetailConfigurator {
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    func view(originalAccount: Account?) -> some View {
        
        let createNewAccountInteractor = injector.instanceOf(CreateNewAccountInteractor.self)
        let deleteAccountInteractor = injector.instanceOf(DeleteAccountInteractor.self)
        let updateAccountInteractor = injector.instanceOf(UpdateAccountInteractor.self)
        let updateRememberPasswordNotificationInteractor = injector.instanceOf(UpdateRememberPasswordNotificationInteractor.self)
        let getLinkMetadataInteractor = injector.instanceOf(GetLinkMetadataInteractor.self)
        let getConfigInteractor = injector.instanceOf(GetConfigInteractor.self)
        let updateConfigInteractor = injector.instanceOf(UpdateConfigInteractor.self)
        let generatePasswordInteractor = injector.instanceOf(GeneratePasswordInteractor.self)
        
        let viewModel = AccountDetailPresenterDefault(
            originalAccount: originalAccount,
            createNewAccountInteractor: createNewAccountInteractor,
            deleteAccountInteractor: deleteAccountInteractor,
            updateAccountInteractor: updateAccountInteractor,
            updateRememberPasswordNotificationInteractor: updateRememberPasswordNotificationInteractor,
            getLinkMetadataInteractor: getLinkMetadataInteractor,
            getConfigInteractor: getConfigInteractor,
            updateConfigInteractor: updateConfigInteractor,
            generatePasswordInteractor: generatePasswordInteractor
        )
        
        let view: some View = AccountDetailView<AccountDetailPresenterDefault>()
            .environmentObject(viewModel)
        
        return view
    }
}
