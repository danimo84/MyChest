//
//  PermissionManager.swift
//  MyChest
//
//  Created by Daniel Moraleda on 27/1/24.
//

import Foundation
import LocalAuthentication
import Combine

enum PermissionType {
    
    case biometricAuth
}

struct Permission {
    let isAccepted: Bool
    let isRequested: Bool
}

enum PermissionManager {
    
    /// If the permission is not determined, it automatically asks for it and retrieve result if permission is requested during proccess
    static func isPermissionGrantedAndRequested(forType type: PermissionType) async -> Permission {
        switch type {
        case .biometricAuth:
            return await BiometricAuth.isPermissionGrantedAndRequested
        }
    }
}

private extension PermissionManager {
    
    enum BiometricAuth {
        
        static var isPermissionGrantedAndRequested: Permission {
            get async {
                return Permission(isAccepted: await askForBiometricAuth().value, isRequested: true)
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
}
