//
//  ConfigRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/1/24.
//

import Foundation
import Combine

protocol ConfigRepository {
    func fetchConfig() -> AnyPublisher<Config, ConfigError>
    func updateConfig(_ config: Config)
}

final class ConfigRepositoryDefault {
    
    private let localDataSource: ConfigLocalDataSource
    
    init(localDataSource: ConfigLocalDataSource) {
        self.localDataSource = localDataSource
    }
}

extension ConfigRepositoryDefault: ConfigRepository {
    
    func fetchConfig() -> AnyPublisher<Config, ConfigError> {
        localDataSource.fetchConfig()
            .map { ConfigMapper.map($0) }
            .mapError { ConfigErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    func updateConfig(_ config: Config) {
        localDataSource.updateConfig(ConfigMapper.mapToEntity(config))
    }
}
