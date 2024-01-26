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
                    Toggle("Usar KeyChain", isOn: $storeInKeyChain)
                    Text("Si usas KeyChain para almacenar tus credenciales y en la configuración del dispositivos tienes activado el iCloud para los llaveros, tus contraseñas viajarán a los servidores de Apple.")
                        .font(.system(size: 12))
                }
                
                Section {
                    Picker("Número de caracteres", selection: $viewModel.passwordGeneratorConfig.charactersNumber) {
                        ForEach(4..<17) { index in
                            Text("\(index)")
                                .tag(index)
                        }
                    }
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
