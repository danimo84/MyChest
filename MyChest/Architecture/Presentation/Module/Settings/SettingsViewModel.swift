//
//  SettingsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation

protocol SettingsViewModel: ObservableObject {
    var config: Config { get set }
    
    func fetchConfig()
}

final class SettingsViewModelDefault {
    
    @Published var config: Config = .defaultConfig()
    
    private let configRepository: ConfigRepository
    
    init(configRepository: ConfigRepository) {
        self.configRepository = configRepository
        fetchConfig()
    }
}

extension SettingsViewModelDefault: SettingsViewModel {
    
    func fetchConfig() {
        config = configRepository.fetchConfig()
        
//        if let passwordConfig = configRepository.fetchConfig().first {
//            config = passwordConfig
//        } else {
//            storeDefaultConfig()
//        }
    }
}

private extension SettingsViewModelDefault {
    
}
