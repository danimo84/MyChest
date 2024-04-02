//
//  GeocoderRemoteDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/4/24.
//

import Foundation
import Combine
import CoreLocation

protocol GeocoderRemoteDataSource {
    func getCoordinates(forAdress address: String) -> AnyPublisher<UserLocationCoordinatesEntity?, DataError>
}

final class GeocoderRemoteDataSourceDefault {
    
    private let geocoderProvider = CLGeocoder()
}

extension GeocoderRemoteDataSourceDefault: GeocoderRemoteDataSource {
    
    func getCoordinates(forAdress address: String) -> AnyPublisher<UserLocationCoordinatesEntity?, DataError> {
        geocoderProvider.fetchPlacemarks(forAdress: address)
            .map {
                guard let placemark = $0.first else {
                    return nil
                }
                return UserLocationCoordinatesEntityMapper.map(placemark)
            }
            .mapError { _ in .invalidAddress }
            .eraseToAnyPublisher()
    }
}
