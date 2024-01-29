//
//  MockTabBarViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftUI

final class MockTabBarViewModel: TabBarViewModel {
    
    var selectedTabItem: Int = 1
    var isAuthenticated: Bool = false
    var settingsPath: NavigationPath = NavigationPath()
    
    func tryAuthentication() {
        // Intentionally empty
    }
}
