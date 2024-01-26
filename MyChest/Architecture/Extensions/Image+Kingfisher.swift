//
//  Image+Kingfisher.swift
//  MyChest
//
//  Created by Daniel Moraleda on 22/1/24.
//

import SwiftUI
import Kingfisher

extension Image {
    
    static func cachedURL(_ url: URL?) -> KFImage {
        KFImage.url(url, cacheKey: url?.cacheKey)
    }
}
