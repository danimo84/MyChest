//
//  GetLInkMetadataInteractor.swift
//  MyChest
//
//  Created by Daniel Moraleda on 3/4/24.
//

import Combine

protocol GetLinkMetadataInteractor {
    func execute(forUrl url: String) -> AnyPublisher<LinkMetadata, GetLinkMetadataError>
}

final class GetLinkMetadataInteractorDefault {
    
    private let linkMetadataRepository: LinkMetadataRepository
    
    init(linkMetadataRepository: LinkMetadataRepository) {
        self.linkMetadataRepository = linkMetadataRepository
    }
}

extension GetLinkMetadataInteractorDefault: GetLinkMetadataInteractor {
    
    func execute(forUrl url: String) -> AnyPublisher<LinkMetadata, GetLinkMetadataError> {
        linkMetadataRepository.getLinkMetadata(forUrl: url)
            .map { LinkMetadataMapper.map($0) }
            .mapError { GetLinkMetadataErrorMapper.map($0) }
            .eraseToAnyPublisher()
    }
}
