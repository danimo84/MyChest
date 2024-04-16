//
//  NotificationsScreenUITests.swift
//  MyChestUITests
//
//  Created by Daniel Moraleda on 15/4/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import MyChest

final class NotificationsScreenUITests: XCTestCase {
    
    func testNotificationsLightScreen() throws {
        let presenter = MockNotificationsPresenter()
        presenter.notifications = LocalNotification.mockList()
        let screen = NotificationsView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        NotificationsUIGroup.screenshots(viewController, name: "notifications_light", colorStyle: .light)
    }
    
    func testNotificationsDarkScreen() throws {
        let presenter = MockNotificationsPresenter()
        presenter.notifications = LocalNotification.mockList()
        let screen = NotificationsView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        NotificationsUIGroup.screenshots(viewController, name: "notifications_dark", colorStyle: .dark)
    }
    
    func testNotificationsEmptyLightScreen() throws {
        let presenter = MockNotificationsPresenter()
        let screen = NotificationsView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        NotificationsUIGroup.screenshots(viewController, name: "notifications_empty_light", colorStyle: .light)
    }
    
    func testNotificationsEmptyDarkScreen() throws {
        let presenter = MockNotificationsPresenter()
        let screen = NotificationsView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        NotificationsUIGroup.screenshots(viewController, name: "notifications_empty_dark", colorStyle: .dark)
    }
}
