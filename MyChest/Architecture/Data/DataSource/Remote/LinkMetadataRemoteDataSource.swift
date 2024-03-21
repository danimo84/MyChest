//
//  LinkMetadataRemoteDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/3/24.
//

import Foundation
import Combine
import LinkPresentation

protocol LinkMetadataRemoteDataSource {
    func getLinkMetadata(forUrl url: String) -> AnyPublisher<LinkMetadataEntity, DataError>
}

final class LinkMetadataRemoteDataSourceDefault: LinkMetadataRemoteDataSource {
    
    func getLinkMetadata(forUrl url: String) -> AnyPublisher<LinkMetadataEntity, DataError> {
        guard let url = URL(string: url) else {
            return Fail(error: DataError.invalidUrl)
                .eraseToAnyPublisher()
        }
        let metadataProvider = LPMetadataProvider()
        return metadataProvider.fetchMetadata(for: url)
            .compactMap({ $0 })
            .mapError { LPMetadaProviderErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
}

struct LPMetadaProviderErrorMapper {
    
    static func map(_ error: Error) -> DataError {
        switch error {
        default:
            return DataError.unknown
        }
    }
}
