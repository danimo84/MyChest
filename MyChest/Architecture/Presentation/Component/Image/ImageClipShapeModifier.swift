//
//  ImageClipShapeModifier.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/3/24.
//

import Foundation
import SwiftUI

struct ImageClipShapeModifier: ViewModifier {
    
    var clippedShape: Bool
    var cornerRadius: CGFloat?
    
    func body(content: Content) -> some View {
        VStack {
            if clippedShape {
                if let cornerRadius {
                    content
                        .clipShape(
                            RoundedRectangle(
                                cornerSize: CGSize(
                                    width: cornerRadius,
                                    height: cornerRadius
                                )
                            )
                        )
                } else {
                    content
                        .clipShape(
                            Circle()
                        )
                }
            } else {
                content
            }
        }
    }
}

extension View {
    
    func clipShapeIfNeeded(
        clippedShape: Bool,
        cornerRadius: CGFloat? = nil
    ) -> some View {
        modifier(
            ImageClipShapeModifier(
                clippedShape: clippedShape,
                cornerRadius: cornerRadius
            )
        )
    }
}
