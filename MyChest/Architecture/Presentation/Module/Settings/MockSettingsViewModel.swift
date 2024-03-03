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
    
    func fetchConfig() {
        // Intentionally empty
    }
    
    func navigateToInfo() {
        // Intentionally empty
    }
    
    func goBack() {
        // Intentionally empty
    }
    
    func requestNotificationsPermission() {
        // Intentionally empty
    }
    
    func isNotificationsToogleValueChange() {
        // Intentionally empty
    }
    
    func isNotificationsAllowed() {
        // Intentionally empty
    }
}
