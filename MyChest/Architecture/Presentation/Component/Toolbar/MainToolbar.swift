//
//  MainToolbar.swift
//  MyChest
//
//  Created by Daniel Moraleda on 9/3/24.
//

import SwiftUI

private typealias builder = ToolbarItemsBuilder

struct MainToolbar: ViewModifier {
    
    let leadingButton: ToolbarButton?
    let tralingButton: ToolbarButton?
    let leadingButtonDisabled: Binding<Bool>
    let tralingButtonDisabled: Binding<Bool>
    let action: ((_ action: ToolbarButton) -> Void)?
    
    init(
        leadingButton: ToolbarButton?,
        tralingButton: ToolbarButton?,
        leadingButtonDisabled: Binding<Bool> = .constant(false),
        tralingButtonDisabled: Binding<Bool> = .constant(false),
        action: ( (_: ToolbarButton) -> Void)?
    ) {
        self.leadingButton = leadingButton
        self.tralingButton = tralingButton
        self.leadingButtonDisabled = leadingButtonDisabled
        self.tralingButtonDisabled = tralingButtonDisabled
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                if let leadingButton {
                    ToolbarItem(placement: .topBarLeading) {
                        builder.button(
                            buttonType: leadingButton,
                            action: action
                        )
                        .disabled(leadingButtonDisabled.wrappedValue)
                    }
                }
                if let tralingButton {
                    ToolbarItem(placement: .topBarTrailing) {
                        builder.button(
                            buttonType: tralingButton,
                            action: action
                        )
                        .disabled(tralingButtonDisabled.wrappedValue)
                    }
                }
            }
    }
}
