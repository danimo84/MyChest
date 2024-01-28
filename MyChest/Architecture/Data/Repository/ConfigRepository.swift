//
//  ConfigRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/1/24.
//

import Foundation

protocol ConfigRepository {
    func fetchConfig() -> Config
}

final class ConfigRepositoryDefault {
    
    private let localDataSource: ConfigLocalDataSource
    
    init(localDataSource: ConfigLocalDataSource) {
        self.localDataSource = localDataSource
    }
}

extension ConfigRepositoryDefault: ConfigRepository {
    
    func fetchConfig() -> Config {
        localDataSource.fetchConfig()
    }
}
