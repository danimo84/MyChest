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

    }
    
    func view() -> some View {
        
        let configRepository = injector.instanceOf(ConfigRepository.self)
        
        let viewModel = SettingsViewModelDefault(configRepository: configRepository)
        
        let view: some View = SettingsView<SettingsViewModelDefault>(viewModel: viewModel)
        
        return view
    }
}
