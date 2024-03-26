//
//  AccountsView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 17/1/24.
//

import SwiftUI
import SwiftData

struct AccountsView<ViewModel: AccountsViewModel>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.accounts) {
                    accountCard($0)
                }
            }
            .navigationTitle(Strings.AccountsScreen.title)
            .toolbar(
                .accounts,
                action: {
                    if $0 == .add {
                        viewModel.selectedAccount = nil
                        viewModel.isAccountSheetPresented = true
                    }
                })
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
            AccountDetailConfigurator().view(originalAccount: viewModel.selectedAccount)
                .presentationDetents([.large])
        }
    }
    
    var defaultImage: some View {
        DefaultImage(
            viewModel: .init(
                width: Theme.Accounts.accountImageSize,
                height: Theme.Accounts.accountImageSize
            )
        )
    }
    
    func remoteImage(_ imageUrl: String) -> some View {
        RemoteImage(
            viewModel: .init(
                widht: Theme.Accounts.accountImageSize,
                height: Theme.Accounts.accountImageSize,
                cornerRadius: Theme.Radius.small,
                clipedShape: true,
                url: imageUrl
            )
        )
    }
    
    func accountCard(_ account: Account) -> some View {
        HStack {
            if !account.image.isEmpty {
                remoteImage(account.image)
            } else {
                defaultImage
            }
            Text(account.domain)
            Spacer()
        }
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.selectedAccount = account
            viewModel.isAccountSheetPresented = true
        }
        .swipeActions {
            Button(
                Strings.AccountsScreen.deletableButton,
                role: .destructive
            ) {
                viewModel.deleteAccount(account)
            }
        }
    }
}

#Preview {
    AccountsView<MockAccountsViewModel>(viewModel: MockAccountsViewModel())
}
