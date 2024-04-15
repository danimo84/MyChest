//
//  TryBiometricAuthInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/4/24.
//

import Foundation

// sourcery: AutoMockable
protocol TryBiometricAuthInteractor {
    func execute() async -> Bool
}

final class TryBiometricAuthInteractorDefault {
    
    private let permissionManager: PermissionsManager
    
    init(permissionManager: PermissionsManager) {
        self.permissionManager = permissionManager
    }
}

extension TryBiometricAuthInteractorDefault: TryBiometricAuthInteractor {
    
    func execute() async -> Bool {
        await permissionManager.isPermissionGrantedAndRequested(forType: .biometricAuth).isAccepted
    }
}
