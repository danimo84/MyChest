//
//  GeocoderRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 30/3/24.
//

import Combine

// sourcery: AutoMockable
protocol GeocoderRepository {
    func getCoordinates(forAdress address: String) -> AnyPublisher<UserLocationCoordinatesEntity, DataError>
}

final class GeocoderRepositoryDefault {
    
    private let remote: GeocoderRemoteDataSource
    
    init(remote: GeocoderRemoteDataSource) {
        self.remote = remote
    }
}

extension GeocoderRepositoryDefault: GeocoderRepository {
    
    func getCoordinates(forAdress address: String) -> AnyPublisher<UserLocationCoordinatesEntity, DataError> {
        remote.getCoordinates(forAdress: address)
            .compactMap {
                $0 ?? UserLocationCoordinatesEntity(latitude: "", longitude: "")
            }
            .eraseToAnyPublisher()
    }
}
