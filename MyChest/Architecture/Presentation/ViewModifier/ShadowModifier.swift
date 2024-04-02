//
//  ShadowModifier.swift
//  MyChest
//
//  Created by Daniel Moraleda on 28/3/24.
//

import Foundation
import SwiftUI

struct ShadowModifier: ViewModifier {
    
    var shadowed: Bool
    var shadowRadius: CGFloat
    var shadowColor: Color
    
    func body(content: Content) -> some View {
        VStack {
            if shadowed {
                content
                    .shadow(
                        color: shadowColor,
                        radius: shadowRadius
                    )
            } else {
                content
            }
        }
    }
}

extension View {
    
    func shadowIfNeeded(
        shadowed: Bool,
        shadowRadius: CGFloat,
        shadowColor: Color
    ) -> some View {
        modifier(
            ShadowModifier(
                shadowed: shadowed,
                shadowRadius: shadowRadius,
                shadowColor: shadowColor
            )
        )
    }
}
