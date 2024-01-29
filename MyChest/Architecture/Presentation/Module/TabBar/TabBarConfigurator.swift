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
        let viewModel = TabBarViewModelDefault()
        
        let view: some View = TabBarView<TabBarViewModelDefault>(viewModel: viewModel)
            
        
        return view
    }
}
