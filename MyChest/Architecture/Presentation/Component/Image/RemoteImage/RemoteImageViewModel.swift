//
//  RemoteImageViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/3/24.
//

import Foundation
import SwiftUI

final class RemoteImageViewModel: ObservableObject {
    
    let width: CGFloat
    let height: CGFloat
    let contentMode: ContentMode
    let cornerRadius: CGFloat?
    let clipedShape: Bool
    let overlied: Bool
    let strokeWidth: CGFloat?
    let strokeColor: Color
    let shadowed: Bool
    let shadowRadius: CGFloat
    let shadowColor: Color
    @Published var url: String
    
    /// wi
    init(
        width: CGFloat,
        height: CGFloat,
        contentMode: ContentMode? = nil,
        cornerRadius: CGFloat? = nil,
        clipedShape: Bool? = nil,
        overlied: Bool? = nil,
        strokeWidth: CGFloat? = nil,
        strokeColor: Color? = nil,
        shadowed: Bool? = nil,
        shadowRadius: CGFloat? = nil,
        shadowColor: Color? = nil,
        url: String
    ) {
        self.width = width
        self.height = height
        self.contentMode = contentMode ?? .fit
        self.cornerRadius = cornerRadius
        self.clipedShape = clipedShape ?? false
        self.overlied = overlied ?? false
        self.strokeWidth = strokeWidth
        self.strokeColor = strokeColor ?? .black
        self.shadowed = shadowed ?? false
        self.shadowRadius = shadowRadius ?? .zero
        self.shadowColor = shadowColor ?? .black
        self.url = url
    }
}
