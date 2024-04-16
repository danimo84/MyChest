//
//  MockSettingsPresenter.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation
import SwiftUI

final class MockSettingsPresenter: SettingsPresenter {
    
    @Published var config: Config = .defaultConfig()
    
    func getConfig() {
        // Intentionally empty
    }
    
    func navigateToInfo() {
        // Intentionally empty
    }
    
    func restoreDefaultConfig() {
        // Intentionally empty
    }
    
    func navigateBack() {
        // Intentionally empty
    }
    
    func isNotificationsToogleValueChange() {
        // Intentionally empty
    }
    
    func isNotificationsAllowed() {
        // Intentionally empty
    }
}
