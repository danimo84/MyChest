//
//  MockMapPresenter.swift
//  MyChest
//
//  Created by Daniel Moraleda on 29/3/24.
//

import Foundation
import CoreLocation

final class MockMapPresenter: MapPresenter {
    
    @Published var latitude: Double = .zero
    @Published var longitude: Double = .zero
    @Published var formattedAddress: String = ""
}
