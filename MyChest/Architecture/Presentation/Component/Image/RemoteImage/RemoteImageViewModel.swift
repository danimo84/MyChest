//
//  RemoteImageViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/3/24.
//

import Foundation
import SwiftUI

final class RemoteImageViewModel: ObservableObject {
    
    let widht: CGFloat
    let height: CGFloat
    let contentMode: ContentMode?
    let cornerRadius: CGFloat?
    let clipedShape: Bool?
    @Published var url: String
    
    init(
        widht: CGFloat,
        height: CGFloat,
        contentMode: ContentMode? = nil,
        cornerRadius: CGFloat? = nil,
        clipedShape: Bool? = nil,
        url: String
    ) {
        self.widht = widht
        self.height = height
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius
        self.clipedShape = clipedShape
        self.url = url
    }
}
