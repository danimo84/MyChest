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
            }
            .navigationTitle(Strings.SettingsScreen.title)
            .navigationDestination(for: SettingsRoute.self, destination: {
                route($0)
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                viewModel.isNotificationsAllowed()
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
        Toggle(Strings.SettingsScreen.notificationsTitle, isOn: $viewModel.config.areNotificationsEnabled)
            .onChange(of: viewModel.config.areNotificationsEnabled) { _, _ in
                viewModel.isNotificationsToogleValueChange()
            }
    }
    
    private func route(_ route: SettingsRoute) -> some View {
        switch route {
        case .info:
            Text("Info")
        }
    }
}

#Preview {
    SettingsView<MockSettingsViewModel>(viewModel: MockSettingsViewModel())
        .environmentObject(MockSettingsViewModel())
}
