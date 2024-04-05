//
//  GetUserInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 5/4/24.
//

import Combine

protocol GetUserInteractor {
    func execute() -> AnyPublisher<User, GetUserError>
}

final class GetUserInteractorDefault {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

extension GetUserInteractorDefault: GetUserInteractor {
    
    func execute() -> AnyPublisher<User, GetUserError> {
        userRepository.getUser()
            .map { UserMapper.map($0) }
            .mapError { GetUserErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
}
