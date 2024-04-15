//
//  LinkMetadata.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/2/24.
//

import Foundation

struct LinkMetadata: ModelDefault {
    
    let id: String
    let title: String
    let description: String
    let url: String
    let imageUrl: String
    
    init(
        title: String,
        description: String,
        url: String,
        imageUrl: String
    ) {
        id = UUID().uuidString
        self.title = title
        self.description = description
        self.url = url
        self.imageUrl = imageUrl
    }
}

extension LinkMetadata {
    
    static func emtpy() -> LinkMetadata {
        .init(
            title: "",
            description: "",
            url: "",
            imageUrl: ""
        )
    }
    
    static func mock() -> LinkMetadata {
        .init(
            title: "Netflix",
            description: "Streaming platform for series, films and documentaries.",
            url: "https://www.netflix.com",
            imageUrl: "https://cdn.icon-icons.com/icons2/3053/PNG/512/netflix_macos_bigsur_icon_189917.png"
        )
    }
}
