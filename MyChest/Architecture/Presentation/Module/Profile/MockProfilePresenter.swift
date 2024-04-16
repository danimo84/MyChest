//
//  MockProfilePresenter.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

final class MockProfilePresenter: ProfilePresenter {
    
    @Published var user: User = .empty()
    @Published var isEditAddressVisible: Bool = false
    @Published var alertIsVisible: Bool = false
    @Published var alertViewModel: AlertViewModel = .empty()
    
    func restoreUserWithRandom() {
        // Intentionally empty
    }
    
    func routeToMap() {
        // Intentionally empty
    }

    func searchLocationAndRouteToMap() {
        // Intentionally empty
    }
}
