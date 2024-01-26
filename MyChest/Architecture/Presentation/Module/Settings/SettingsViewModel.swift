//
//  SettingsViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation

protocol SettingsViewModel: ObservableObject {
    
    var passwordGeneratorConfig: PasswordGeneratorConfig { get set }
}

final class SettingsViewModelDefault {
    
    @Published var passwordGeneratorConfig: PasswordGeneratorConfig = .defaultConfig()
    
    init() {
        
    }
}

extension SettingsViewModelDefault: SettingsViewModel {
    
}
