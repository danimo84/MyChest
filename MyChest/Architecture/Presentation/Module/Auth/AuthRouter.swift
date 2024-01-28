//
//  AuthRouter.swift
//  MyChest
//
//  Created by Daniel Moraleda on 27/1/24.
//

import Foundation
import SwiftUI

protocol AuthRouter {
    func navigateToMain()
}

final class AuthRouterDefault {
    
    private var navigationPath: NavigationPath
    
    init(navigationPath: NavigationPath) {
        self.navigationPath = navigationPath
    }
}

extension AuthRouterDefault: AuthRouter {
    
    func navigateToMain() {
        navigationPath.append("main")
    }
}
