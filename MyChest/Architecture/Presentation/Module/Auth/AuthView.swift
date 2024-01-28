//
//  AuthView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 27/1/24.
//

import SwiftUI

struct AuthView<ViewModel: AuthViewModel>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isAuthenticated {
                Image(systemName: "lock.open.iphone")
                    .resizable()
                    .frame(width: 300, height: 500)
            } else {
                Image(systemName: "lock.iphone")
                    .resizable()
                    .frame(width: 300, height: 500)
            }
        }
            .onAppear {
                if !viewModel.isAuthenticated {
                    viewModel.tryAuthentication()
                }
            }
    }
}

#Preview {
    AuthView<MockAuthViewModel>()
        .environmentObject(MockAuthViewModel())
}
