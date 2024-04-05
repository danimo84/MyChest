//
//  SettingsView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import SwiftUI

struct SettingsView<ViewModel: SettingsViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.settingsNavigationPath) {
            List {
                generalSection
                PasswordGeneratorSettings(
                    charactersNumber: $viewModel.config.charactersNumber,
                    requireUpper: $viewModel.config.requireUpper,
                    requireLower: $viewModel.config.requireLower,
                    requireNumber: $viewModel.config.requireNumber,
                    requireSpecialCharacter: $viewModel.config.requireSpecialCharacter,
                    showHeader: true
                )
                defaultConfigButton
            }
            .navigationTitle(Strings.SettingsScreen.title)
            .navigationDestination(for: SettingsRoute.self, destination: {
                switch $0 {
                case .profile:
                    ProfileConfigurator().view()
                case .map(let latitude, let longitude, let address):
                    MapConfigurator().view(latitude: latitude, longitude: longitude, formattedAddress: address)
                }
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                viewModel.isNotificationsAllowed()
            }
            .onAppear {
                viewModel.getConfig()
            }
        }
    }
    
    var generalSection: some View {
        Section {
            infoItem
            notificationsToggle
        } header: {
            Text(Strings.SettingsScreen.generalHeader)
        }
    }
    
    var infoItem: some View {
        HStack {
            Text(Strings.SettingsScreen.informationTitle)
            Spacer()
            Image(systemName: Assets.SystemImage.chevronRight)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.navigateToInfo()
        }
    }
    
    var notificationsToggle: some View {
        Toggle(
            Strings.SettingsScreen.notificationsTitle,
            isOn: $viewModel.config.areNotificationsEnabled
        )
        .onChange(of: viewModel.config.areNotificationsEnabled) { _, _ in
            viewModel.isNotificationsToogleValueChange()
        }
    }
    
    var defaultConfigButton: some View {
        Button(Strings.SettingsScreen.defaultConfigButtonTitle) {
            viewModel.restoreDefaultConfig()
        }
    }
}

#Preview {
    SettingsView<MockSettingsViewModel>(viewModel: MockSettingsViewModel())
        .environmentObject(MockSettingsViewModel())
}
