//
//  MockTabBarPresenter.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftUI

final class MockTabBarPresenter: TabBarPresenter {
    
    var isAuthenticated: Bool = false
    
    func tryAuthentication() {
        // Intentionally empty
    }
}
