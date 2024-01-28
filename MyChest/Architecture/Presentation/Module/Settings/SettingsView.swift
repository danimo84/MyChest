//
//  SettingsView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import SwiftUI

struct SettingsView<ViewModel: SettingsViewModel>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var storeInKeyChain: Bool = false
    
    var body: some View {
        NavigationStack() {
            List {
                Section {
                    HStack {
                        Text("Información")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    
                    Toggle("Notificaciones", isOn: $viewModel.config.areNotificationsEnabled)
                    Toggle("Usar KeyChain", isOn: $viewModel.config.storeInKeyChain)
                    Text("Si usas KeyChain para almacenar tus credenciales y en la configuración del dispositivos tienes activado el iCloud para los llaveros, tus contraseñas viajarán a los servidores de Apple.")
                        .font(.system(size: 12))
                } header: {
                    Text("General")
                }
                
                Section {
                    Picker("Número de caracteres", selection: $viewModel.config.charactersNumber) {
                        ForEach(Constants.PasswordGenerator.minChars..<Constants.PasswordGenerator.maxChars, id: \.self) { index in
                            Text("\(index)")
                                .tag(index)
                        }
                    }
                    Toggle("Mayúsculas", isOn: $viewModel.config.requireUpper)
                    Toggle("Minúsculas", isOn: $viewModel.config.requireLower)
                    Toggle("Números", isOn: $viewModel.config.requireNumber)
                    Toggle("Especiales", isOn: $viewModel.config.requireSpecialCharacter)
                } header: {
                    Text("Generador de contraseñas")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView<MockSettingsViewModel>()
        .environmentObject(MockSettingsViewModel())
}
