//
//  UpdateConfigInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/4/24.
//

import Combine

// sourcery: AutoMockable
protocol UpdateConfigInteractor {
    func execute(_ config: Config)
}

final class UpdateConfigInteractorDefault {
    
    private let configRepository: ConfigRepository
    
    init(configRepository: ConfigRepository) {
        self.configRepository = configRepository
    }
}

extension UpdateConfigInteractorDefault: UpdateConfigInteractor {
    
    func execute(_ config: Config) {
        configRepository.updateConfig(ConfigMapper.mapToEntity(config))
    }
}
