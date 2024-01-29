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
    @State var isAccountSheetPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            List() {
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
                        isAccountSheetPresented = true
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
                        isAccountSheetPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onChange(of: isAccountSheetPresented) {
                if !isAccountSheetPresented {
                    viewModel.fetchAccounts()
                }
            }
        }
        .sheet(isPresented: $isAccountSheetPresented) {
            AddAccountConfigurator().view(isPresented: $isAccountSheetPresented, originalAccount: viewModel.selectedAccount)
                .presentationDetents([.large])
        }
    }
}

#Preview {
    AccountsView<MockAccountsViewModel>()
        .environmentObject(MockAccountsViewModel())
}
