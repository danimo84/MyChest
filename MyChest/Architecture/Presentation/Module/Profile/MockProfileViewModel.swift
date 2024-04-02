//
//  MockProfileViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

final class MockProfileViewModel: ProfileViewModel {
    
    var user: User = .mockUser()
    var isEditAddressVisible: Bool = false
    var alertIsVisible: Bool = false
    var alertViewModel: AlertViewModel = .empty()
    
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
