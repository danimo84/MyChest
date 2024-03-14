//
//  Toolbar.swift
//  MyChest
//
//  Created by Daniel Moraleda on 9/3/24.
//

import Foundation
import SwiftUI

extension View {
    
    @ViewBuilder
    func toolbar(
        _ style: ToolbarStyle.Main,
        leadingButtonDisabled: Binding<Bool> = .constant(false),
        tralingButtonDisabled: Binding<Bool> = .constant(false),
        action: ((_ action: ToolbarButton) -> Void)? = nil
    ) -> some View {
        switch style {
        case .accounts:
            toolbarForAccountScreen(action)
        case .accountDetail(let isNewAccount):
            if isNewAccount {
                toolbarForNewAccountScreen(
                    tralingButtonDisabled,
                    action
                )
            } else {
                toolbarForAccountDetailScreen(action)
            }
        }
    }
    
    private func toolbarForAccountScreen(_ action: ( (_: ToolbarButton) -> Void)?) -> some View {
        modifier(
            MainToolbar(
                leadingButton: nil,
                tralingButton: .add,
                action: action
            )
        )
    }
    
    private func toolbarForNewAccountScreen(_ tralingButtonDisabled: Binding<Bool>, _ action: ( (_: ToolbarButton) -> Void)?) -> some View {
        modifier(
            MainToolbar(
                leadingButton: .cancel,
                tralingButton: .save,
                tralingButtonDisabled: tralingButtonDisabled,
                action: action
            )
        )
    }
    
    private func toolbarForAccountDetailScreen(_ action: ( (_: ToolbarButton) -> Void)?) -> some View {
        modifier(
            MainToolbar(
                leadingButton: .delete,
                tralingButton: nil,
                action: action
            )
        )
    }
}
