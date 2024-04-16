//
//  AccountDetailScreenTests.swift
//  MyChestUITests
//
//  Created by Daniel Moraleda on 15/4/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import MyChest

final class AccountDetailScreenTests: XCTestCase {
    
    func testNewAccountDetailLightScreen() throws {
        let presenter = MockAccountDetailPresenter()
        presenter.newAccount = true
        presenter.isPasswordEditable = true
        let screen = AccountDetailView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "account_detail_new_light", colorStyle: .light)
    }
    
    func testNewAccountDetailDarkScreen() throws {
        let presenter = MockAccountDetailPresenter()
        presenter.newAccount = true
        presenter.isPasswordEditable = true
        let screen = AccountDetailView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "account_detail_new_dark", colorStyle: .dark)
    }
    
    func testAccountDetailLightScreen() throws {
        let presenter = MockAccountDetailPresenter()
        presenter.account = .mock()
        let screen = AccountDetailView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "account_detail_light", colorStyle: .light)
    }
    
    func testAccountDetailDarkScreen() throws {
        let presenter = MockAccountDetailPresenter()
        presenter.account = .mock()
        let screen = AccountDetailView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "account_detail_dark", colorStyle: .dark)
    }
    
    func testAccountDetailPassSecuredLightScreen() throws {
        let presenter = MockAccountDetailPresenter()
        presenter.account = .mock()
        presenter.isPasswordSecured = true
        let screen = AccountDetailView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "account_detail_pass_sec_light", colorStyle: .light)
    }
    
    func testAccountDetailPassSecuredDarkScreen() throws {
        let presenter = MockAccountDetailPresenter()
        presenter.account = .mock()
        presenter.isPasswordSecured = true
        let screen = AccountDetailView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "account_detail_pass_sec_dark", colorStyle: .dark)
    }
    
    func testAccountDetailImageLoadingLightScreen() throws {
        let presenter = MockAccountDetailPresenter()
        presenter.account = .mock()
        presenter.isMetadataLoading = true
        let screen = AccountDetailView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "account_detail_image_loading_light", colorStyle: .light)
    }
    
    func testAccountDetailImageLoadingDarkScreen() throws {
        let presenter = MockAccountDetailPresenter()
        presenter.account = .mock()
        presenter.isMetadataLoading = true
        let screen = AccountDetailView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        AccountsUIGroup.screenshots(viewController, name: "account_detail_image_loading_dark", colorStyle: .dark)
    }
}
