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
            TabView(selection: $router.selectedTabItem) {
                NotificationsConfigurator().view()
                    .tabItem {
                        Label("Notificaciones", systemImage: "bell")
                            .onTapGesture {
                                router.selectedTabItem = 1
                            }
                    }
                    .tag(1)
                AccountsConfigurator().view()
                    .tabItem {
                        Label("Accounts", systemImage: "key")
                            .onTapGesture {
                                router.selectedTabItem = 2
                            }
                    }
                    .tag(2)
                SettingsConfigurator().view()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                            .onTapGesture {
                                router.selectedTabItem = 3
                            }
                    }
                    .tag(3)
            }
        } else {
            VStack {
                Spacer()
                Image(systemName: "lock.iphone")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 64)
                Spacer()
                Button("Login") {
                    viewModel.tryAuthentication()
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

#Preview {
    TabBarView<MockTabBarViewModel>(viewModel: MockTabBarViewModel())
        .environmentObject(MockTabBarViewModel())
}
