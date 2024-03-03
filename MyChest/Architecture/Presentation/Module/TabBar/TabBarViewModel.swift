//
//  TabBarViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation
import SwiftUI

protocol TabBarViewModel: ObservableObject {
    
    var isAuthenticated: Bool { get set }
    
    func tryAuthentication()
}

final class TabBarViewModelDefault {
    
    @Published var isAuthenticated: Bool = false
    
    private let router: Router = Router.shared
    
    init() {
        
    }
}

extension TabBarViewModelDefault: TabBarViewModel {
 
    @MainActor
    func tryAuthentication() {
        Task {
            isAuthenticated = await PermissionsManager.isPermissionGrantedAndRequested(forType: .biometricAuth).isAccepted
        }
        
    }
}
