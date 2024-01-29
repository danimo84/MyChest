//
//  SettingsConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import SwiftUI

struct SettingsConfigurator {
    
    private let navigationPath: NavigationPath
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    init(navigationPath: NavigationPath) {
        self.navigationPath = navigationPath
    }
    
    func view() -> some View {
        
        let configRepository = injector.instanceOf(ConfigRepository.self)
        
        let viewModel = SettingsViewModelDefault(
            configRepository: configRepository,
            settingsPath: navigationPath
        )
        
        let view: some View = SettingsView<SettingsViewModelDefault>(viewModel: viewModel)
        
        return view
    }
}
