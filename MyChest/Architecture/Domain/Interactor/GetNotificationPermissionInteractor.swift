//
//  GetNotificationPermissionInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 4/4/24.
//

import Foundation

// sourcery: AutoMockable
protocol GetNotificationPermissionInteractor {
    func execute(initialValue: Bool) async -> Bool?
}

final class GetNotificationPermissionInteractorDefault {
    
    private let permissionManager: PermissionsManager
    
    init(permissionManager: PermissionsManager) {
        self.permissionManager = permissionManager
    }
}

extension GetNotificationPermissionInteractorDefault: GetNotificationPermissionInteractor {
    
    func execute(initialValue: Bool) async -> Bool? {
        let status = await permissionManager.isNotificationEnabled
        if status != initialValue {
            StorageManager.shared.areNotificationsEnabled = status
            return status
        }
        return nil
    }
}
