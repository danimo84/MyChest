//
//  RandomUserRemoteDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation
import Combine

protocol RandomUserRemoteDataSource {
    func randomUser() -> AnyPublisher<RandomUserResponseEntity, DataError>
}

final class RandomUserRemoteDataSourceDefault: RandomUserRemoteDataSource {
    
    func randomUser() -> AnyPublisher<RandomUserResponseEntity, DataError> {
        guard let request = API.RandomUser.RandomUserAPI.randomUser.urlRequest else {
            return Fail(error: DataError.invalidUrl)
                .eraseToAnyPublisher()
        }
        return RemoteDataSource.run(request)
    }
}
