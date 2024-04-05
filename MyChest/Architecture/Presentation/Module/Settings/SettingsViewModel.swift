//
//  SettingsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation
import Combine

protocol SettingsViewModel: ObservableObject {
    var config: Config { get set }
    
    func getConfig()
    func isNotificationsToogleValueChange()
    func isNotificationsAllowed()
    func restoreDefaultConfig()
    func navigateToInfo()
    func navigateBack()
}

final class SettingsViewModelDefault {
    
    @Published var config: Config = .defaultConfig() {
        didSet {
            updateConfigInteractor.execute(config)
        }
    }
    private var subscriptions = Set<AnyCancellable>()
    
    private let getConfigInteractor: GetConfigInteractor
    private let updateConfigInteractor: UpdateConfigInteractor
    private let updateNotificationPermissionInteractor: UpdateNotificationPermissionInteractor
    private let getNotificationPermissionInteractor: GetNotificationPermissionInteractor
    private let router: Router = Router.shared
    
    init(
        getConfigInteractor: GetConfigInteractor,
        updateConfigInteractor: UpdateConfigInteractor,
        updateNotificationPermissionInteractor: UpdateNotificationPermissionInteractor,
        getNotificationPermissionInteractor: GetNotificationPermissionInteractor
    ) {
        self.getConfigInteractor = getConfigInteractor
        self.updateConfigInteractor = updateConfigInteractor
        self.updateNotificationPermissionInteractor = updateNotificationPermissionInteractor
        self.getNotificationPermissionInteractor = getNotificationPermissionInteractor
    }
}

extension SettingsViewModelDefault: SettingsViewModel {
    
    func getConfig() {
        fetchConfig()
        setNotificationEnabledCurrentState(value: StorageManager.shared.areNotificationsEnabled)
    }
    
    func restoreDefaultConfig() {
        config = .defaultConfig(
            id: config.id,
            notificationsEnabled: config.areNotificationsEnabled
        )
    }

    func navigateToInfo() {
        routeToInfo()
    }
    
    func navigateBack() {
        routeToBack()
    }
    
    func isNotificationsToogleValueChange() {
        Task { await updateNotificationPermission() }
    }
    
    func isNotificationsAllowed() {
        Task { await getNotificationPermission() }
    }
}

private extension SettingsViewModelDefault {
    
    func fetchConfig() {
        getConfigInteractor.execute()
            .sink(receiveCompletion: {
                if case let .failure(error) = $0 {
                    print("Error: \(error)")
                }
            }, receiveValue: {
                self.config = $0
            })
            .store(in: &subscriptions)
    }
    
    @MainActor
    func updateNotificationPermission() async {
        guard let value = await updateNotificationPermissionInteractor.execute(initialValue: config.areNotificationsEnabled) else {
            return
        }
        config.areNotificationsEnabled = value
    }
    
    @MainActor
    func getNotificationPermission() async {
        guard let status = await getNotificationPermissionInteractor.execute(initialValue: config.areNotificationsEnabled) else {
            return
        }
        config.areNotificationsEnabled = status
    }
    
    func setNotificationEnabledCurrentState(value: Bool) {
        config.areNotificationsEnabled = value
    }
}

private extension SettingsViewModelDefault {
    
    private func routeToInfo() {
        router.navigateTo(route: .profile, onPath: .settings)
    }
    
    private func routeToBack() {
        router.pop(onPath: .settings)
    }
}
