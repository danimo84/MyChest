//
//  MockSettingsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation

final class MockSettingsViewModel: SettingsViewModel {
    
    var config: Config = .defaultConfig()
    
    func fetchConfig() {
        // Intentionally empty
    }
}
