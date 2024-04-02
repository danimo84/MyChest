//
//  TextFieldHeader.swift
//  MyChest
//
//  Created by Daniel Moraleda on 1/4/24.
//

import SwiftUI

struct TextFieldHeader: View {
    
    let placeholder: LocalizedStringKey
    
    var body: some View {
        HStack {
            Text(placeholder)
                .font(Theme.Font.caption)
                .foregroundStyle(.gray)
            Spacer()
        }
    }
}

#Preview {
    TextFieldHeader(placeholder: "Nombre")
}
