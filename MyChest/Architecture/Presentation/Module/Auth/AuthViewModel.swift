//
//  AuthViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 27/1/24.
//

import Foundation

protocol AuthViewModel: ObservableObject {
    var isAuthenticated: Bool { get set }
    
    func tryAuthentication()
}

final class AuthViewModelDefault {
    
    @Published var isAuthenticated: Bool = false {
        didSet {
            if isAuthenticated {
                router.navigateToMain()
            }
        }
    }
    
    private let router: AuthRouter
    
    init(router: AuthRouter) {
        self.router = router
    }
}

extension AuthViewModelDefault: AuthViewModel {
    
    @MainActor
    func tryAuthentication() {
        Task {
            isAuthenticated = await PermissionManager.isPermissionGrantedAndRequested(forType: .biometricAuth).isAccepted
        }
        
    }
}
