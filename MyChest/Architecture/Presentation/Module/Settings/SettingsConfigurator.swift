//
//  SettingsConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import SwiftUI

struct SettingsConfigurator {
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    init() {
        // Intentionally empty
    }
    
    func view() -> some View {
        let getConfigInteractor = injector.instanceOf(GetConfigInteractor.self)
        let updateConfigInteractor = injector.instanceOf(UpdateConfigInteractor.self)
        let updateNotificationPermissionInteractor = injector.instanceOf(UpdateNotificationPermissionInteractor.self)
        let getNotificationPermissionInteractor = injector.instanceOf(GetNotificationPermissionInteractor.self)
        
        let presenter = SettingsPresenterDefault(
            getConfigInteractor: getConfigInteractor,
            updateConfigInteractor: updateConfigInteractor,
            updateNotificationPermissionInteractor: updateNotificationPermissionInteractor,
            getNotificationPermissionInteractor: getNotificationPermissionInteractor
        )
        
        let view: some View = SettingsView<SettingsPresenterDefault>(presenter: presenter)
        
        return view
    }
}
