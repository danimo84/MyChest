//
//  GetConfigInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/4/24.
//

import Combine

protocol GetConfigInteractor {
    func execute() -> AnyPublisher<Config, GetConfigError>
}

final class GetConfigInteractorDefault {
    
    private let configRepository: ConfigRepository
    
    init(configRepository: ConfigRepository) {
        self.configRepository = configRepository
    }
}

extension GetConfigInteractorDefault: GetConfigInteractor {
    
    func execute() -> AnyPublisher<Config, GetConfigError> {
        configRepository.fetchConfig()
            .map { ConfigMapper.map($0) }
            .mapError { GetConfigErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
}
