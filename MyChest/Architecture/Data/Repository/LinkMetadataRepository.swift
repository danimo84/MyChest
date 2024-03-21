//
//  LinkMetadataRepository.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/3/24.
//

import Combine

protocol LinkMetadataRepository {
    func getLinkMetadata(forUrl url: String) -> AnyPublisher<LinkMetadata, LinkMetadataError>
}

final class LinkMetadataRepositoryDefault {

    private let remote: LinkMetadataRemoteDataSource
    
    init(remoteDataSource: LinkMetadataRemoteDataSource) {
        remote = remoteDataSource
    }
}

extension LinkMetadataRepositoryDefault: LinkMetadataRepository {
    
    func getLinkMetadata(forUrl url: String) -> AnyPublisher<LinkMetadata, LinkMetadataError> {
        remote
            .getLinkMetadata(forUrl: url)
            .map { LinkMetadataMapper.map($0) }
            .mapError { LinkMetadataErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
}
