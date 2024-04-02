//
//  ProfileConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import SwiftUI

struct ProfileConfigurator {
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    init() {
        // Intentionally empty
    }
    
    func view() -> some View {
        let userRepository = injector.instanceOf(UserRepository.self)
        let geocoderRepository = injector.instanceOf(GeocoderRepository.self)
        
        let viewModel = ProfileViewModelDefault(
            userRepository: userRepository,
            geocoderRepository: geocoderRepository
        )
        
        let view: some View = ProfileView<ProfileViewModelDefault>()
            .environmentObject(viewModel)
        
        return view
    }
}
