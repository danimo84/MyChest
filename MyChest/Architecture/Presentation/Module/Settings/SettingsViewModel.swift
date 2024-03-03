//
//  SettingsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation
import SwiftUI

//enum SettingsRoute: String, Hashable {
//    case info
//}

protocol SettingsViewModel: ObservableObject {
    var config: Config { get set }
    
    func fetchConfig()
    func requestNotificationsPermission()
    func isNotificationsToogleValueChange()
    func isNotificationsAllowed()
    func navigateToInfo()
    func goBack()
}

final class SettingsViewModelDefault {
    
    @Published var config: Config = .defaultConfig()
    
    private let configRepository: ConfigRepository
    private let router: Router = Router.shared
    
    init(
        configRepository: ConfigRepository
    ) {
        self.configRepository = configRepository
        fetchConfig()
    }
}

extension SettingsViewModelDefault: SettingsViewModel {
    
    func fetchConfig() {
        config = configRepository.fetchConfig()
        config.areNotificationsEnabled = StorageManager.shared.areNotificationsEnabled
    }

    func navigateToInfo() {
        router.navigateTo(route: .info, onPath: .settings)
    }
    
    func goBack() {
        router.pop(onPath: .settings)
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
