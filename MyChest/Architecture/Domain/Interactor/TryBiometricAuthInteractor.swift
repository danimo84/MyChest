//
//  TryBiometricAuthInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/4/24.
//

import Foundation

protocol TryBiometricAuthInteractor {
    func execute() async -> Bool
}

final class TryBiometricAuthInteractorDefault {
    
}

extension TryBiometricAuthInteractorDefault: TryBiometricAuthInteractor {
    
    func execute() async -> Bool {
        await PermissionsManager.isPermissionGrantedAndRequested(forType: .biometricAuth).isAccepted
    }
}
