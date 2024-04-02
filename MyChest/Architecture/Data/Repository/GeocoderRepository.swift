//
//  GeocoderRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 30/3/24.
//

import Combine

protocol GeocoderRepository {
    func getCoordinates(forAdress address: String) -> AnyPublisher<UserCoordinates, UserCoordinatesError>
}

final class GeocoderRepositoryDefault {
    
    private let remote: GeocoderRemoteDataSource
    
    init(remote: GeocoderRemoteDataSource) {
        self.remote = remote
    }
}

extension GeocoderRepositoryDefault: GeocoderRepository {
    
    func getCoordinates(forAdress address: String) -> AnyPublisher<UserCoordinates, UserCoordinatesError> {
        remote.getCoordinates(forAdress: address)
            .map {
                guard let coordinates = $0 else {
                    return UserCoordinates(
                        latitude: "",
                        longitude: ""
                    )
                }
                return UserCoordinateMapper.map(coordinates)
            }
            .mapError { UserCoordinatesErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
}
