//
//  ConfigRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/1/24.
//

import Combine

// sourcery: AutoMockable
protocol ConfigRepository {
    func fetchConfig() -> AnyPublisher<ConfigEntity, DataError>
    func updateConfig(_ config: ConfigEntity)
}

final class ConfigRepositoryDefault {
    
    private let localDataSource: ConfigLocalDataSource
    
    init(localDataSource: ConfigLocalDataSource) {
        self.localDataSource = localDataSource
    }
}

extension ConfigRepositoryDefault: ConfigRepository {
    
    func fetchConfig() -> AnyPublisher<ConfigEntity, DataError> {
        localDataSource.fetchConfig()
    }
    
    func updateConfig(_ config: ConfigEntity) {
        localDataSource.updateConfig(config)
    }
}
