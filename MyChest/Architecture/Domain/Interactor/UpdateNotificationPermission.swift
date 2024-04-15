//
//  UpdateNotificationPermissionInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 4/4/24.
//

import Foundation

// sourcery: AutoMockable
protocol UpdateNotificationPermissionInteractor {
    func execute(initialValue: Bool) async -> Bool?
}

final class UpdateNotificationPermissionInteractorDefault {
    
    private let permissionManager: PermissionsManager
    
    init(permissionManager: PermissionsManager) {
        self.permissionManager = permissionManager
    }
}

extension UpdateNotificationPermissionInteractorDefault: UpdateNotificationPermissionInteractor {
    
    func execute(initialValue: Bool) async -> Bool? {
        if initialValue {
            let permission = await permissionManager.isPermissionGrantedAndRequested(forType: .notifications)
            
            StorageManager.shared.areNotificationsEnabled = permission.isAccepted
            if !permission.isAccepted {
                permissionManager.openPermissionsSettings()
            }
            return permission.isAccepted
        } else {
            permissionManager.openPermissionsSettings()
            return nil
        }
    }
}
