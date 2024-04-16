//
//  SettingsView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import SwiftUI

struct SettingsView<Presenter: SettingsPresenter>: View {
    
    @StateObject var presenter: Presenter
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.settingsNavigationPath) {
            List {
                generalSection
                PasswordGeneratorSettings(
                    charactersNumber: $presenter.config.charactersNumber,
                    requireUpper: $presenter.config.requireUpper,
                    requireLower: $presenter.config.requireLower,
                    requireNumber: $presenter.config.requireNumber,
                    requireSpecialCharacter: $presenter.config.requireSpecialCharacter,
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
                presenter.isNotificationsAllowed()
            }
            .onAppear {
                presenter.getConfig()
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
            presenter.navigateToInfo()
        }
    }
    
    var notificationsToggle: some View {
        Toggle(
            Strings.SettingsScreen.notificationsTitle,
            isOn: $presenter.config.areNotificationsEnabled
        )
        .onChange(of: presenter.config.areNotificationsEnabled) { _, _ in
            presenter.isNotificationsToogleValueChange()
        }
    }
    
    var defaultConfigButton: some View {
        Button(Strings.SettingsScreen.defaultConfigButtonTitle) {
            presenter.restoreDefaultConfig()
        }
    }
}

#Preview {
    SettingsView<MockSettingsPresenter>(presenter: MockSettingsPresenter())
        .environmentObject(MockSettingsPresenter())
}
