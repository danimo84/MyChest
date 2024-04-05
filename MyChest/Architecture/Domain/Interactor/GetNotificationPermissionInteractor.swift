//
//  GetNotificationPermissionInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 4/4/24.
//

import Foundation

protocol GetNotificationPermissionInteractor {
    func execute(initialValue: Bool) async -> Bool?
}

final class GetNotificationPermissionInteractorDefault {
    
}

extension GetNotificationPermissionInteractorDefault: GetNotificationPermissionInteractor {
    
    func execute(initialValue: Bool) async -> Bool? {
        let status = await PermissionsManager.isNotificationEnabled
        if status != initialValue {
            StorageManager.shared.areNotificationsEnabled = status
            return status
        }
        return nil
    }
}
