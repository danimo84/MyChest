//
//  RequestNotificationPermissionIfNeededInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/4/24.
//

import Combine

// sourcery: AutoMockable
protocol RequestNotificationPermissionIfNeededInteractor {
    func execute() async
}

final class RequestNotificationPermissionIfNeededInteractorDefault {
    
    private let storageManager: StorageManager
    private let permissionManager: PermissionsManager
    
    init(
        storageManager: StorageManager,
        permissionManager: PermissionsManager
    ) {
        self.storageManager = storageManager
        self.permissionManager = permissionManager
    }
}

extension RequestNotificationPermissionIfNeededInteractorDefault: RequestNotificationPermissionIfNeededInteractor {
    
    func execute() async {
        let permission = await permissionManager.isPermissionGrantedAndRequested(forType: .notifications)
        storageManager.areNotificationsEnabled = permission.isAccepted
    }
}
