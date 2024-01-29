//
//  MockSettingsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation
import SwiftUI

final class MockSettingsViewModel: SettingsViewModel {
    
    var config: Config = .defaultConfig()
    var settingsPath: NavigationPath = NavigationPath()
    
    func fetchConfig() {
        // Intentionally empty
    }
    
    func navigate(route: SettingsRoute) {
        // Intentionally empty
    }
    
    func pop() {
        // Intentionally empty
    }
}
