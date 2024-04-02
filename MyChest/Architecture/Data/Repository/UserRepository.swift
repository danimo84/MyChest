//
//  UserRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation
import Combine

protocol UserRepository {
    func getUser() -> AnyPublisher<User, UserError>
    func updateUser(_ user: User)
    func removeAll()
}

final class UserRepositoryDefault {
    
    private let remote: RandomUserRemoteDataSource
    private let local: UserLocalDataSource
    
    init(
        remote: RandomUserRemoteDataSource,
        local: UserLocalDataSource
    ) {
        self.remote = remote
        self.local = local
    }
}

extension UserRepositoryDefault: UserRepository {
    
    func getUser() -> AnyPublisher<User, UserError> {
        local.fetchUser()
            .mapError { UserErrorMapper.map($0) }
            .flatMap {
                guard let user = $0 else {
                    return self.remote.randomUser()
                        .handleEvents(receiveOutput: {
                            if let user = $0.results?.first {
                                self.local.insertUser(user)
                            }
                        })
                        .map { UserMapper.map($0.results?.first ?? .emptyUser()) }
                        .mapError { UserErrorMapper.map($0) }
                        .eraseToAnyPublisher()
                }
                return Just(UserMapper.map(user))
                    .setFailureType(to: UserError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func updateUser(_ user: User) {
        _ = local.updateUser(UserMapper.mapToEntity(user))
    }
    
    func removeAll() {
        local.removeAll()
    }
}
