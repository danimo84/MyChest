//
//  TextFieldValueHeadered.swift
//  MyChest
//
//  Created by Daniel Moraleda on 1/4/24.
//

import SwiftUI

struct TextFieldValueHeadered: View {
    
    @Binding var value: Int
    var placeholder: LocalizedStringKey
    
    var body: some View {
        VStack {
            if !value.description.isEmpty {
                TextFieldHeader(placeholder: placeholder)
            }
            TextField(placeholder, value: $value, formatter: NumberFormatter())
                .keyboardType(.numberPad)
        }
    }
}

#Preview {
    @State var value: Int = .zero
    
    return TextFieldValueHeadered(
        value: $value,
        placeholder: "Placeholder number"
    )
}
