//
//  LinkMetadataRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/3/24.
//

import Combine

// sourcery: AutoMockable
protocol LinkMetadataRepository {
    func getLinkMetadata(forUrl url: String) -> AnyPublisher<LinkMetadataEntity, DataError>
}

final class LinkMetadataRepositoryDefault {

    private let remote: LinkMetadataRemoteDataSource
    
    init(remoteDataSource: LinkMetadataRemoteDataSource) {
        remote = remoteDataSource
    }
}

extension LinkMetadataRepositoryDefault: LinkMetadataRepository {
    
    func getLinkMetadata(forUrl url: String) -> AnyPublisher<LinkMetadataEntity, DataError> {
        remote.getLinkMetadata(forUrl: url)
    }
}
