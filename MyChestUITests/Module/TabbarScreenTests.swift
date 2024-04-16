//
//  TabbarScreenTests.swift
//  MyChestUITests
//
//  Created by Daniel Moraleda on 15/4/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import MyChest

final class TabbarScreenTests: XCTestCase {
    
    func testTabbarNoAuthenticatedLightScreen() throws {
        let presenter = MockTabBarPresenter()
        presenter.isAuthenticated = false
        let screen = TabBarView(presenter: presenter)
            .environmentObject(Router.shared)
        let viewController = UIHostingController(rootView: screen)
        TabbarUIGroup.screenshots(viewController, name: "tabbar_no_authenticated_light", colorStyle: .light)
    }
    
    func testTabbarNoAuthenticatedDarkScreen() throws {
        let presenter = MockTabBarPresenter()
        presenter.isAuthenticated = false
        let screen = TabBarView(presenter: presenter)
            .environmentObject(Router.shared)
        let viewController = UIHostingController(rootView: screen)
        TabbarUIGroup.screenshots(viewController, name: "tabbar_no_authenticated_dark", colorStyle: .dark)
    }
    
    func testTabbarAuthenticatedLightScreen() throws {
        let presenter = MockTabBarPresenter()
        presenter.isAuthenticated = true
        let screen = TabBarView(presenter: presenter)
            .environmentObject(Router.shared)
        let viewController = UIHostingController(rootView: screen)
        TabbarUIGroup.screenshots(viewController, name: "tabbar_authenticated_light", colorStyle: .light)
    }
    
    func testTabbarAuthenticatedDarkScreen() throws {
        let presenter = MockTabBarPresenter()
        presenter.isAuthenticated = true
        let screen = TabBarView(presenter: presenter)
            .environmentObject(Router.shared)
        let viewController = UIHostingController(rootView: screen)
        TabbarUIGroup.screenshots(viewController, name: "tabbar_authenticated_dark", colorStyle: .dark)
    }
}
