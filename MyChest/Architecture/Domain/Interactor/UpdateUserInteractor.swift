//
//  UpdateUserInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 5/4/24.
//

import Foundation

protocol UpdateUserInteractor {
    func execute(_ user: User)
}

final class UpdateUserInteractorDefault {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

extension UpdateUserInteractorDefault: UpdateUserInteractor {
    
    func execute(_ user: User) {
        userRepository.updateUser(user)
    }
}
