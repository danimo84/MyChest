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
    
    func view() -> some View {
        let viewModel = SettingsViewModelDefault()
        
        let view: some View = SettingsView<SettingsViewModelDefault>()
            .environmentObject(viewModel)
        
        return view
    }
}
