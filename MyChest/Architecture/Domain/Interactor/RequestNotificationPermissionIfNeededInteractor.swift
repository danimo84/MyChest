//
//  RequestNotificationPermissionIfNeededInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/4/24.
//

import Combine

protocol RequestNotificationPermissionIfNeededInteractor {
    func execute() async
}

final class RequestNotificationPermissionIfNeededInteractorDefault {
    
    let storageManager: StorageManager
    
    init(storageManager: StorageManager) {
        self.storageManager = storageManager
    }
}

extension RequestNotificationPermissionIfNeededInteractorDefault: RequestNotificationPermissionIfNeededInteractor {
    
    func execute() async {
        let permission = await PermissionsManager.isPermissionGrantedAndRequested(forType: .notifications)
        StorageManager.shared.areNotificationsEnabled = permission.isAccepted
    }
}
