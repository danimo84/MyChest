//
//  TabBarViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation
import SwiftUI

protocol TabBarViewModel: ObservableObject {
    
    var selectedTabItem: Int { get set }
    var isAuthenticated: Bool { get set }
    var settingsPath: NavigationPath { get set }
    
    func tryAuthentication()
}

final class TabBarViewModelDefault {
    
    @Published var selectedTabItem: Int = 2
    @Published var isAuthenticated: Bool = false
    @Published var settingsPath: NavigationPath = NavigationPath()
}

extension TabBarViewModelDefault: TabBarViewModel {
 
    @MainActor
    func tryAuthentication() {
        Task {
            isAuthenticated = await PermissionManager.isPermissionGrantedAndRequested(forType: .biometricAuth).isAccepted
        }
        
    }
}
