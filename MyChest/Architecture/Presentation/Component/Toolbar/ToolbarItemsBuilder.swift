//
//  ToolbarItemsBuilder.swift
//  MyChest
//
//  Created by Daniel Moraleda on 13/3/24.
//

import Foundation
import SwiftUI

enum ToolbarItemsBuilder {
    
    private static var addImage: some View {
        Image(systemName: Assets.SystemImage.plus)
    }
    
    private static var saveText: some View {
        Text(Strings.Toolbar.saveButton)
    }
    
    private static var deleteText: some View {
        Text(Strings.Toolbar.delteButton)
            .foregroundStyle(.red)
    }
    
    private static var cancelText: some View {
        Text(Strings.Toolbar.cancelButton)
    }
    
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
                addImage
            case .save:
                saveText
            case .delete:
                deleteText
            case .cancel:
                cancelText
            }
        }
    }
}
