//
//  MockMapPresenter.swift
//  MyChest
//
//  Created by Daniel Moraleda on 29/3/24.
//

import Foundation
import CoreLocation

final class MockMapPresenter: MapPresenter {
    
    var latitude: Double = Double("40.3091556") ?? .zero
    var longitude: Double = Double("-3.7303882") ?? .zero
    var formattedAddress: String = "Calle Velasco 23, Getafe Madrid"
}
