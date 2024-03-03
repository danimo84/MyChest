//
//  LinkMetadata.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/2/24.
//

import Foundation

struct LinkMetadata: ModelDefault {
    
    let id: String
    let title: String?
    let description: String?
    let url: String?
    let imageUrl: String?
    
    init(
        title: String?,
        description: String?,
        url: String?,
        imageUrl: String?
    ) {
        id = UUID().uuidString
        self.title = title
        self.description = description
        self.url = url
        self.imageUrl = imageUrl
    }
}
