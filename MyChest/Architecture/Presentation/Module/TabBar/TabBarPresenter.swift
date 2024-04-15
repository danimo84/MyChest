//
//  TabBarPresenter.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation
import SwiftUI

protocol TabBarPresenter: ObservableObject {
    
    var isAuthenticated: Bool { get set }
    
    func tryAuthentication()
}

final class TabBarPresenterDefault {
    
    @Published var isAuthenticated: Bool = false
    
    private let tryBiometricAuthInteractor: TryBiometricAuthInteractor
    private let router: Router = Router.shared
    
    init(tryBiometricAuthInteractor: TryBiometricAuthInteractor) {
        self.tryBiometricAuthInteractor = tryBiometricAuthInteractor
    }
}

extension TabBarPresenterDefault: TabBarPresenter {
 
    @MainActor
    func tryAuthentication() {
        Task {
            isAuthenticated = await tryBiometricAuthInteractor.execute()
        }
    }
}
