//
//  TabBarConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import SwiftUI

struct TabBarConfigurator {
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    func view() -> some View {
        let tryBiometricAuthInteractor = injector.instanceOf(TryBiometricAuthInteractor.self)
        
        let viewModel = TabBarViewModelDefault(tryBiometricAuthInteractor: tryBiometricAuthInteractor)
        
        let view: some View = TabBarView<TabBarViewModelDefault>(viewModel: viewModel)
        
        return view
    }
}
