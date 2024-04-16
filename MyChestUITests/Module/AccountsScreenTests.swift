//
//  AccountsScreenTests.swift
//  MyChestUITests
//
//  Created by Daniel Moraleda on 15/4/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import MyChest

final class AccountsScreenTests: XCTestCase {
    
    func testAccountsLightScreen() throws {
        let presenter = MockAccountsPresenter()
        presenter.accounts = Account.mockList()
        let screen = AccountsView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "accounts_content_light", colorStyle: .light)
    }
    
    func testAccountsDarkcreen() throws {
        let presenter = MockAccountsPresenter()
        presenter.accounts = Account.mockList()
        let screen = AccountsView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "accounts_content_dark", colorStyle: .dark)
    }
    
    func testEmptyAccountsLightScreen() throws {
        let presenter = MockAccountsPresenter()
        let screen = AccountsView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "accounts_empty_state_light", colorStyle: .light)
    }
    
    func testEmptyAccountsDarkcreen() throws {
        let presenter = MockAccountsPresenter()
        let screen = AccountsView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "accounts_empty_state_dark", colorStyle: .dark)
    }
}
