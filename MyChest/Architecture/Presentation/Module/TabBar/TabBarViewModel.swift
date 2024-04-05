//
//  TabBarViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation
import SwiftUI

protocol TabBarViewModel: ObservableObject {
    
    var isAuthenticated: Bool { get set }
    
    func tryAuthentication()
}

final class TabBarViewModelDefault {
    
    @Published var isAuthenticated: Bool = false
    
    private let tryBiometricAuthInteractor: TryBiometricAuthInteractor
    private let router: Router = Router.shared
    
    init(tryBiometricAuthInteractor: TryBiometricAuthInteractor) {
        self.tryBiometricAuthInteractor = tryBiometricAuthInteractor
    }
}

extension TabBarViewModelDefault: TabBarViewModel {
 
    @MainActor
    func tryAuthentication() {
        Task {
            isAuthenticated = await tryBiometricAuthInteractor.execute()
        }
    }
}
