//
//  ProfileScreenUITests.swift
//  MyChestUITests
//
//  Created by Daniel Moraleda on 15/4/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import MyChest

final class ProfileScreenUITests: XCTestCase {
    
    func testProfileLightScreen() throws {
        let presenter = MockProfilePresenter()
        presenter.user = .mockUser()
        let screen = ProfileView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        ProfileUIGroup.screenshots(viewController, name: "profile_light", colorStyle: .light)
    }
    
    func testProfileDarkScreen() throws {
        let presenter = MockProfilePresenter()
        presenter.user = .mockUser()
        let screen = ProfileView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        ProfileUIGroup.screenshots(viewController, name: "profile_dark", colorStyle: .dark)
    }
}
