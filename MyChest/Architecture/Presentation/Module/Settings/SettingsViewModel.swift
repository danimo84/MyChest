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
    }
    
    func navigate(route: SettingsRoute) {
        settingsPath.append(route)
    }
    
    func pop() {
        settingsPath.removeLast()
    }
}

private extension SettingsViewModelDefault {
    
}
