//
//  TabBarView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import SwiftUI

struct TabBarView<ViewModel: TabBarViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        if viewModel.isAuthenticated {
            TabView(selection: $viewModel.selectedTabItem) {
                Text("Notificaciones")
                    .tabItem {
                        Label("Notificaciones", systemImage: "bell")
                            .onTapGesture {
                                viewModel.selectedTabItem = 1
                            }
                    }
                    .tag(1)
                AccountsConfigurator().view()
                    .tabItem {
                        Label("Accounts", systemImage: "key")
                            .onTapGesture {
                                viewModel.selectedTabItem = 2
                            }
                    }
                    .tag(2)
                SettingsConfigurator(navigationPath: viewModel.settingsPath).view()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                            .onTapGesture {
                                viewModel.selectedTabItem = 3
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
