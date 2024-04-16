//
//  MapUIGroup.swift
//  MyChestUITests
//
//  Created by Daniel Moraleda on 15/4/24.
//

import UIKit
import SnapshotTesting

final class MapUIGroup: UIGroup {
    
    static var identifier: String = "Map"
    
    static func screenshots(_ viewController: UIViewController, name: String, colorStyle: UIUserInterfaceStyle) {
        _ = UITheme.Devices.list.map { device in
            assertSnapshot(
                of: viewController,
                as: .image(on: device.value, traits: UITraitCollection(userInterfaceStyle: colorStyle)),
                named: "\(identifier)-\(name)-\(device.key)"
            )
        }
    }
}

