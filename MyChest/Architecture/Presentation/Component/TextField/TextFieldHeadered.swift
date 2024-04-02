//
//  TextFieldHeadered.swift
//  MyChest
//
//  Created by Daniel Moraleda on 31/3/24.
//

import SwiftUI

struct TextFieldHeadered: View {
    
    @Binding var text: String
    var placeholder: LocalizedStringKey
    
    var body: some View {
        VStack {
            if !text.isEmpty {
                TextFieldHeader(placeholder: placeholder)
            }
            TextField(placeholder, text: $text)
        }
    }
}

#Preview {
    @State var text: String = ""
    
    return TextFieldHeadered(
        text: $text,
        placeholder: "Placeholder text"
    )
}
