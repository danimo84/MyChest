//
//  AccountsView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 17/1/24.
//

import SwiftUI
import SwiftData

struct AccountsView<ViewModel: AccountsViewModel>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.accounts) { account in
                    HStack {
                        if !account.image.isEmpty, let imageUrl = URL(string: account.image) {
                            Image.cachedURL(imageUrl)
                                .resizable()
                                .frame(width: 36, height: 36)
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image(systemName: "photo")
                                .resizable()
                                .frame(width: 36, height: 36)
                        }
                        Text(account.domain)
                    }
                    .onTapGesture {
                        viewModel.selectedAccount = account
                        viewModel.isAccountSheetPresented = true
                    }
                    .swipeActions {
                        Button("Borrar", role: .destructive) {
                            viewModel.deleteAccount(account)
                        }
                    }
                }
            }
            .navigationTitle("Accounts")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.selectedAccount = nil
                        viewModel.isAccountSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onChange(of: viewModel.isAccountSheetPresented) {
                if !viewModel.isAccountSheetPresented {
                    viewModel.fetchAccounts()
                }
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
        .sheet(isPresented: $viewModel.isAccountSheetPresented) {
            AddAccountConfigurator().view(isPresented: $viewModel.isAccountSheetPresented, originalAccount: viewModel.selectedAccount)
                .presentationDetents([.large])
        }
    }
}

#Preview {
    AccountsView<MockAccountsViewModel>()
        .environmentObject(MockAccountsViewModel())
}
