//
//  PermissionsManager.swift
//  MyChest
//
//  Created by Daniel Moraleda on 27/1/24.
//

import Foundation
import LocalAuthentication
import Combine
import UserNotifications
import UIKit

enum PermissionType {
    
    case biometricAuth
    case notifications
}

struct Permission {
    let isAccepted: Bool
    let wasRequested: Bool
}

enum PermissionsManager {
    
    /// If the permission is not determined, it automatically asks for it and retrieve result if permission is requested during proccess
    static func isPermissionGrantedAndRequested(forType type: PermissionType) async -> Permission {
        switch type {
        case .biometricAuth:
            return await BiometricAuth.isPermissionGrantedAndRequested
        case .notifications:
            return await Notifications.isNotificationsPermissionGrantedAndRequested
        }
    }
    
    /// Only return notifications auth status
    static var isNotificationEnabled: Bool {
        get async {
            return await Notifications.isNotificationsPermissionGranted
        }
    }
}

private extension PermissionsManager {
    
    enum BiometricAuth {
        
        static var isPermissionGrantedAndRequested: Permission {
            get async {
                return Permission(isAccepted: await askForBiometricAuth().value, wasRequested: true)
            }
        }
        
        static func askForBiometricAuth() -> Future<Bool, Never> {
            Future { promise in
                let context = LAContext()
                var error: NSError?
                
                guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
                    print(error?.localizedDescription ?? "Can't evaluate policy")
                    promise(.success(false))
                    return
                }
                
                Task {
                    do {
                        try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to your account")
                        promise(.success(true))
                    } catch let error {
                        print(error.localizedDescription)
                        promise(.success(false))
                    }
                }
            }
        }
    }
    
    enum Notifications {
        
        static var isNotificationsPermissionGrantedAndRequested: Permission {
            get async {
                await checkNotificationsPermission().value
            }
        }
        
        static var isNotificationsPermissionGranted: Bool {
            get async {
                await checkNotificationsPermission().value
            }
        }
        
        static func checkNotificationsPermission() -> Future<Bool, Never> {
            Future { promise in
                let current = UNUserNotificationCenter.current()
                current.getNotificationSettings { permission in
                    switch permission.authorizationStatus {
                    case .authorized:
                        promise(.success(true))
                    case .denied:
                        promise(.success(false))
                    case .notDetermined:
                        Task {
                            promise(.success(await askForNotificationsPermission().value))
                        }
                    default:
                        promise(.success(false))
                    }
                }
            }
        }
        
        static func checkNotificationsPermission() -> Future<Permission, Never> {
            Future { promise in
                let current = UNUserNotificationCenter.current()
                current.getNotificationSettings { permission in
                    switch permission.authorizationStatus {
                    case .authorized:
                        promise(.success(Permission(isAccepted: true, wasRequested: false)))
                    case .denied:
                        promise(.success(Permission(isAccepted: false, wasRequested: false)))
                    case .notDetermined:
                        Task {
                            promise(.success(Permission(isAccepted: await askForNotificationsPermission().value, wasRequested: true)))
                        }
                    default:
                        promise(.success(Permission(isAccepted: false, wasRequested: false)))
                    }
                }
            }
        }
        
        static func askForNotificationsPermission() -> Future<Bool, Never> {
            Future { promise in
                let current = UNUserNotificationCenter.current()
                current.requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                    promise(.success(granted))
                }
            }
        }
    }
}

extension PermissionsManager {
    
    static func openPermissionsSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}
