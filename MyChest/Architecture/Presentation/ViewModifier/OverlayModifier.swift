//
//  OverlayModifier.swift
//  MyChest
//
//  Created by Daniel Moraleda on 28/3/24.
//

import Foundation
import SwiftUI

struct OverlayModifier: ViewModifier {
    
    var overlaied: Bool
    var strokeWidth: CGFloat
    var strokeColor: Color
    var cornerRadius: CGFloat?
    
    func body(content: Content) -> some View {
        VStack {
            if overlaied {
                if let cornerRadius {
                    content
                        .overlay {
                            RoundedRectangle(
                                cornerSize: CGSize(
                                    width: cornerRadius,
                                    height: cornerRadius
                                )
                            )
                            .stroke(strokeColor, lineWidth: strokeWidth)
                        }
                } else {
                    content
                        .overlay {
                            Circle()
                                .stroke(strokeColor, lineWidth: strokeWidth)
                        }
                }
            } else {
                content
            }
        }
    }
}

extension View {
    
    func overlayIfNeeded(
        overlaied: Bool,
        strokeWidth: CGFloat,
        strokeColor: Color,
        cornerRadius: CGFloat? = nil
    ) -> some View {
        modifier(
            OverlayModifier(
                overlaied: overlaied,
                strokeWidth: strokeWidth,
                strokeColor: strokeColor,
                cornerRadius: cornerRadius
            )
        )
    }
}
