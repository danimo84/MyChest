//
//  LinkMetadataMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/3/24.
//

import Foundation

struct LinkMetadataMapper {
    
    static func map(_ entity: LinkMetadataEntity) -> LinkMetadata {
        .init(
            title: entity.title,
            description: entity.description,
            url: entity.url,
            imageUrl: entity.imageUrl
        )
    }
}
