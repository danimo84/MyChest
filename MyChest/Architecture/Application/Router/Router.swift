//
//  Router.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/2/24.
//

import Foundation
import SwiftUI

final class Router: ObservableObject {
    
    @Published var selectedTabItem: Int = 2
    @Published var settingsNavigationPath: NavigationPath
    
    static let shared = Router()
    
    init() {
        settingsNavigationPath = NavigationPath()
    }
    
    func navigateTo(route: SettingsRoute, onPath: RoutePath) {
        switch onPath {
        case .settings:
            settingsNavigationPath.append(route)
        }
    }
    
    func pop(onPath: RoutePath) {
        switch onPath {
        case .settings:
            settingsNavigationPath.removeLast()
        }
    }
}

extension Router {
     
    func navigateToAccountsAndStoreRoutingToId(_ id: String) {
        StorageManager.shared.accountIdToNavigate = id
        selectedTabItem = 2
    }
    
    func checkPendingAccountNavigation() -> String? {
        let accountId = StorageManager.shared.accountIdToNavigate
        StorageManager.shared.clearPendingNavigations()
        return accountId
    }
}

enum SettingsRoute: String, Hashable {
    case info
}

enum RoutePath: String {
    case settings
}
