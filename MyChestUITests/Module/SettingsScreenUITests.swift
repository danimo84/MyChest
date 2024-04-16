//
//  SettingsScreenUITests.swift
//  MyChestUITests
//
//  Created by Daniel Moraleda on 15/4/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import MyChest

final class SettingsScreenUITests: XCTestCase {
    
    func testSettingsLightScreent() throws {
        let presenter = MockSettingsPresenter()
        let screen = SettingsView(presenter: presenter)
            .environmentObject(Router.shared)
        let viewController = UIHostingController(rootView: screen)
        SettingsUIGroup.screenshots(viewController, name: "settings_light", colorStyle: .light)
    }
    
    func testSettingsDarkScreent() throws {
        let presenter = MockSettingsPresenter()
        let screen = SettingsView(presenter: presenter)
            .environmentObject(Router.shared)
        let viewController = UIHostingController(rootView: screen)
        SettingsUIGroup.screenshots(viewController, name: "settings_dark", colorStyle: .dark)
    }
}
