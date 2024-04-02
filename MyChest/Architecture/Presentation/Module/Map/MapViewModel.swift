//
//  MapViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 29/3/24.
//

import Foundation

protocol MapViewModel: ObservableObject {
    var latitude: Double { get set }
    var longitude: Double { get set }
    var formattedAddress: String { get set }
}

final class MapViewModelDefault {
    
    @Published var latitude: Double
    @Published var longitude: Double
    @Published var formattedAddress: String
    
    init(
        latitude: String,
        longitude: String,
        formattedAddress: String
    ) {
        self.latitude = Double(latitude) ?? .zero
        self.longitude = Double(longitude) ?? .zero
        self.formattedAddress = formattedAddress
    }
}

extension MapViewModelDefault: MapViewModel {

}
