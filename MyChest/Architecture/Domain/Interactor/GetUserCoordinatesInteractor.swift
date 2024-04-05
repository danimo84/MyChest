//
//  GetUserCoordinatesInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 5/4/24.
//

import Combine

protocol GetUserCoordinatesInteractor{
    func execute(forAddress address: String) -> AnyPublisher<UserCoordinates, GetUserCoordinatesError>
}

final class GetUserCoordinatesInteractorDefault {
    
    private let geocoderRepository: GeocoderRepository
    
    init(geocoderRepository: GeocoderRepository) {
        self.geocoderRepository = geocoderRepository
    }
}

extension GetUserCoordinatesInteractorDefault: GetUserCoordinatesInteractor {
    
    func execute(forAddress address: String) -> AnyPublisher<UserCoordinates, GetUserCoordinatesError> {
        geocoderRepository.getCoordinates(forAdress: address)
            .map { UserCoordinateMapper.map($0) }
            .mapError { GetUserCoordinatesErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
}
