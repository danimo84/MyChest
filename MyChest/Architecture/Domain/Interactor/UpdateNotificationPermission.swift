//
//  UpdateNotificationPermissionInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 4/4/24.
//

import Foundation

protocol UpdateNotificationPermissionInteractor {
    func execute(initialValue: Bool) async -> Bool?
}

final class UpdateNotificationPermissionInteractorDefault {
    
}

extension UpdateNotificationPermissionInteractorDefault: UpdateNotificationPermissionInteractor {
    
    func execute(initialValue: Bool) async -> Bool? {
        if initialValue {
            let permission = await PermissionsManager.isPermissionGrantedAndRequested(forType: .notifications)
            
            StorageManager.shared.areNotificationsEnabled = permission.isAccepted
            if !permission.isAccepted {
                PermissionsManager.openPermissionsSettings()
            }
            return permission.isAccepted
        } else {
            PermissionsManager.openPermissionsSettings()
            return nil
        }
    }
}
