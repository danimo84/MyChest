//
//  SettingsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation
import SwiftUI

enum SettingsRoute: String, Hashable {
    case info
}

protocol SettingsViewModel: ObservableObject {
    var config: Config { get set }
    var settingsPath: NavigationPath { get set }
    
    func fetchConfig()
    func navigate(route: SettingsRoute)
    func pop()
    func requestNotificationsPermission()
    func isNotificationsToogleValueChange()
    func isNotificationsAllowed()
}

final class SettingsViewModelDefault {
    
    @Published var config: Config = .defaultConfig()
    @Published var settingsPath: NavigationPath
    
    private let configRepository: ConfigRepository
    
    init(
        configRepository: ConfigRepository,
        settingsPath: NavigationPath
    ) {
        self.configRepository = configRepository
        self.settingsPath = settingsPath
        fetchConfig()
    }
}

extension SettingsViewModelDefault: SettingsViewModel {
    
    func fetchConfig() {
        config = configRepository.fetchConfig()
        config.areNotificationsEnabled = StorageManager.shared.areNotificationsEnabled
    }
    
    func navigate(route: SettingsRoute) {
        settingsPath.append(route)
    }
    
    func pop() {
        settingsPath.removeLast()
    }
    
    @MainActor
    func requestNotificationsPermission() {
        Task {
            let permission = await PermissionsManager.isPermissionGrantedAndRequested(forType: .notifications)
            if !permission.isAccepted {
                config.areNotificationsEnabled = false
                StorageManager.shared.areNotificationsEnabled = false
                if !permission.wasRequested {
                    PermissionsManager.openPermissionsSettings()
                }
            }
            if permission.isAccepted {
                config.areNotificationsEnabled = true
                StorageManager.shared.areNotificationsEnabled = true
            }
        }
    }
    
    func isNotificationsToogleValueChange() {
        if config.areNotificationsEnabled {
            Task {
                await requestNotificationsPermission()
            }
        } else {
            PermissionsManager.openPermissionsSettings()
        }
    }
    
    @MainActor
    func isNotificationsAllowed() {
        Task {
            let status = await PermissionsManager.isNotificationEnabled
            if status != config.areNotificationsEnabled {
                config.areNotificationsEnabled = status
                StorageManager.shared.areNotificationsEnabled = status
            }
        }
    }
}

private extension SettingsViewModelDefault {
    
    
}
