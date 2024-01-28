//
//  AuthConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 27/1/24.
//

import SwiftUI

struct AuthConfigurator {
    
    private let navigationPath: NavigationPath
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    init(navigationPath: NavigationPath) {
        self.navigationPath = navigationPath
    }
    
    func view() -> some View {
        let router = AuthRouterDefault(navigationPath: navigationPath)
        
        let viewModel = AuthViewModelDefault(router: router)
        
        let view: some View = AuthView<AuthViewModelDefault>()
            .environmentObject(viewModel)
        
        return view
    }
}
