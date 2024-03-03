//
//  SettingsView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import SwiftUI

struct SettingsView<ViewModel: SettingsViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    @State var storeInKeyChain: Bool = false
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.settingsNavigationPath) {
            List {
                Section {
                    HStack {
                        Text("Información")
                            .onTapGesture {
                                viewModel.navigateToInfo()
                            }
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    
                    Toggle("Notificaciones", isOn: $viewModel.config.areNotificationsEnabled)
                        .onChange(of: viewModel.config.areNotificationsEnabled) { _, _ in
                            viewModel.isNotificationsToogleValueChange()
                        }
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
            .navigationDestination(for: SettingsRoute.self, destination: { routes in
                switch routes {
                case .info:
                    Text("Info")
                }
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                viewModel.isNotificationsAllowed()
            }
        }
    }
}

#Preview {
    SettingsView<MockSettingsViewModel>(viewModel: MockSettingsViewModel())
        .environmentObject(MockSettingsViewModel())
}
