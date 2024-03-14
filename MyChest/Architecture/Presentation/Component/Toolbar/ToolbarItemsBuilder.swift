//
//  ToolbarItemsBuilder.swift
//  MyChest
//
//  Created by Daniel Moraleda on 13/3/24.
//

import Foundation
import SwiftUI

enum ToolbarItemsBuilder {
    
    static func button(buttonType: ToolbarButton, action: ((_ action: ToolbarButton) -> Void)?) -> some View {
        Button {
            action?(buttonType)
        } label: {
            buttonLabel(toolbarBotton: buttonType)
        }
    }
    
    static func buttonLabel(toolbarBotton: ToolbarButton) -> some View {
        Group {
            switch toolbarBotton {
            case .add:
                Image(systemName: Assets.SystemImage.plus)
            case .save:
                Text(Strings.Toolbar.saveButton)
            case .delete:
                Text(Strings.Toolbar.delteButton)
                    .foregroundStyle(.red)
            case .cancel:
                Text(Strings.Toolbar.cancelButton)
            }
        }
    }
}
