//
//  CLGeocoder+Extension.swift
//  MyChest
//
//  Created by Daniel Moraleda on 30/3/24.
//

import Foundation
import CoreLocation
import Combine

extension CLGeocoder {
    
    func fetchPlacemarks(forAdress address: String) -> AnyPublisher<[CLPlacemark], Error> {
        
        Future<[CLPlacemark], Error> { completion in
            self.geocodeAddressString(address) { placemarks, error in
                if let error {
                    completion(.failure(error))
                } else {
                    if let placemarks = placemarks {
                        completion(.success(placemarks))
                    } else {
                        completion(.success([]))
                    }
                }
            }
        }
        .handleEvents(receiveCancel: {
            self.cancelGeocode()
        })
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
