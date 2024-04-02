//
//  MapConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 29/3/24.
//

import SwiftUI
import CoreLocation

struct MapConfigurator {
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    init() {
        // Intentionally empty
    }
    
    func view(
        latitude: String,
        longitude: String,
        formattedAddress: String
    ) -> some View {
        let viewModel = MapViewModelDefault(
            latitude: latitude,
            longitude: longitude,
            formattedAddress: formattedAddress
        )
        let view: some View = MapView<MapViewModelDefault>()
            .environmentObject(viewModel)
        
        return view
    }
}
