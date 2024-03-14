//
//  PasswordGeneratorSettings.swift
//  MyChest
//
//  Created by Daniel Moraleda on 10/3/24.
//

import SwiftUI

struct PasswordGeneratorSettings: View {
    
    @Binding var charactersNumber: Int
    @Binding var requireUpper: Bool
    @Binding var requireLower: Bool
    @Binding var requireNumber: Bool
    @Binding var requireSpecialCharacter: Bool
    let showHeader: Bool
    
    var body: some View {
        Section {
            charactersPicker
            uppersToogle
            lowersToogle
            numbersToogle
            specialCharsToogle
        } header: {
            if showHeader {
                Text(Strings.PasswordGenerator.header)
            }
        }
    }
    
    private var charactersPicker: some View {
        Picker(
            Strings.PasswordGenerator.charactersNumberTitle,
            selection: $charactersNumber
        ) {
            ForEach(
                Theme.PasswordGenerator.minChars..<Theme.PasswordGenerator.maxChars,
                id: \.self) {
                Text("\($0)")
                    .tag($0)
            }
        }
    }
    
    private var uppersToogle: some View {
        Toggle(Strings.PasswordGenerator.upperTitle, isOn: $requireUpper)
    }
    
    private var lowersToogle: some View {
        Toggle(Strings.PasswordGenerator.lowerTitle, isOn: $requireLower)
    }
    
    private var numbersToogle: some View {
        Toggle(Strings.PasswordGenerator.numbersTitle, isOn: $requireNumber)
    }
    
    private var specialCharsToogle: some View {
        Toggle(Strings.PasswordGenerator.specialCharsTitle, isOn: $requireSpecialCharacter)
    }
}

#Preview {
    PasswordGeneratorSettings(
        charactersNumber: .constant(2),
        requireUpper: .constant(true),
        requireLower: .constant(true),
        requireNumber: .constant(true),
        requireSpecialCharacter: .constant(true),
        showHeader: true
    )
}
