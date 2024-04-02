//
//  UserLocalDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation
import Combine

protocol UserLocalDataSource {
    func fetchUser() -> AnyPublisher<UserEntity?, DataError>
    func insertUser(_ user: UserEntity)
    func updateUser(_ user: UserEntity)
    func removeAll()
}

final class UserLocalDataSourceDefault {
    
    private let databaseManager = DatabaseManager.shared
    
    init() {
        // Intentionally empty
    }
}

extension UserLocalDataSourceDefault: UserLocalDataSource {
    
    func fetchUser() -> AnyPublisher<UserEntity?, DataError> {
        guard let user = UserEntityCache.fetchUser(using: databaseManager.modelContext) else {
            return Just(nil)
                .setFailureType(to: DataError.self)
                .eraseToAnyPublisher()
        }
        return Just(user)
            .setFailureType(to: DataError.self)
            .map { UserEntityMapper.map($0) }
            .eraseToAnyPublisher()
    }
    
    func insertUser(_ user: UserEntity) {
        UserEntityCache.insertUser(
            UserEntityMapper.mapToCache(user),
            using: databaseManager.modelContext
        )
    }
    
    func updateUser(_ user: UserEntity) {
        _ = UserEntityCache.updateUser(
            user,
            using: databaseManager.modelContext
        )
    }
    
    func removeAll() {
        UserEntityCache.removeAll(using: databaseManager.modelContext)
    }
}
