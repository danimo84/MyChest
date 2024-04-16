//
//  MapScreenUITests.swift
//  MyChestUITests
//
//  Created by Daniel Moraleda on 15/4/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import MyChest

final class MapScreenUITests: XCTestCase {
    
    func testMapLightScreen() throws {
        let presenter = MockMapPresenter()
        presenter.formattedAddress = "Cupertino, California EEUU"
        presenter.latitude = 37.319311
        presenter.longitude = -122.028336
        let screen = MapView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        MapUIGroup.screenshots(viewController, name: "map_light", colorStyle: .light)
    }
    
    func testMapDarkScreen() throws {
        let presenter = MockMapPresenter()
        presenter.formattedAddress = "Cupertino, California EEUU"
        presenter.latitude = 37.319311
        presenter.longitude = -122.028336
        let screen = MapView(presenter: presenter)
        let viewController = UIHostingController(rootView: screen)
        MapUIGroup.screenshots(viewController, name: "map_dark", colorStyle: .dark)
    }
}
