//
//  TabBarView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import SwiftUI

struct TabBarView<ViewModel: TabBarViewModel>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        TabView(selection: $viewModel.selectedTabItem) {
            AccountsConfigurator().view()
                .tabItem {
                    Label("Accounts", systemImage: "key")
                        .onTapGesture {
                            viewModel.selectedTabItem = 1
                        }
                }
                .tag(1)
            SettingsConfigurator().view()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                        .onTapGesture {
                            viewModel.selectedTabItem = 2
                        }
                }
                .tag(2)
        }
    }
}

#Preview {
    TabBarView<MockTabBarViewModel>()
        .environmentObject(MockTabBarViewModel())
}
