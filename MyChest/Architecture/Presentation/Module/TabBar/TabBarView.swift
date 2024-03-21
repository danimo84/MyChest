//
//  TabBarView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import SwiftUI

struct TabBarView<ViewModel: TabBarViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        if viewModel.isAuthenticated {
            tabView
        } else {
            lockedStateView
        }
    }
    
    var tabView: some View {
        TabView(selection: $router.selectedTabItem) {
            notificationsTab
            accountsTab
            settingsTab
        }
    }
    
    var notificationsTab: some View {
        NotificationsConfigurator().view()
            .tabItem {
                Label(
                    Strings.MainScreen.notificationsTab,
                    systemImage: Assets.SystemImage.bell
                )
                .onTapGesture {
                    router.selectedTabItem = Theme.Tabbar.notifications
                }
            }
            .tag(Theme.Tabbar.notifications)
    }
    
    var accountsTab: some View {
        AccountsConfigurator().view()
            .tabItem {
                Label(
                    Strings.MainScreen.accountsTab,
                    systemImage: Assets.SystemImage.key
                )
                .onTapGesture {
                    router.selectedTabItem = Theme.Tabbar.accounts
                }
            }
            .tag(Theme.Tabbar.accounts)
    }
    
    var settingsTab: some View {
        SettingsConfigurator().view()
            .tabItem {
                Label(
                    Strings.MainScreen.settingsTab,
                    systemImage: Assets.SystemImage.gearshape
                )
                .onTapGesture {
                    router.selectedTabItem = Theme.Tabbar.settings
                }
            }
            .tag(Theme.Tabbar.settings)
    }
    
    var lockedStateView: some View {
        VStack {
            Spacer()
            Image(systemName: Assets.SystemImage.lockIphone)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, Theme.Spacing.xxLarge)
            Spacer()
            Button(Strings.MainScreen.loginButton) {
                viewModel.tryAuthentication()
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    TabBarView<MockTabBarViewModel>(viewModel: MockTabBarViewModel())
        .environmentObject(MockTabBarViewModel())
}
