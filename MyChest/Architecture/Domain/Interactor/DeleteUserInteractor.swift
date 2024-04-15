//
//  DeleteUserInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 5/4/24.
//

import Foundation

// sourcery: AutoMockable
protocol DeleteUserInteractor {
    func execute()
}

final class DeleteUserInteractorDefault {
    
    private let userRepository: UserRepository
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
}

extension DeleteUserInteractorDefault: DeleteUserInteractor {
    
    func execute() {
        userRepository.removeAll()
    }
}
