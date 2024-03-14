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
            AccountDetailConfigurator().view(isPresented: $viewModel.isAccountSheetPresented, originalAccount: viewModel.selectedAccount)
                .presentationDetents([.large])
        }
    }
    
    var defaultImage: some View {
        Image(systemName: Assets.SystemImage.photo)
            .resizable()
            .frame(
                width: Theme.Accounts.accountImageSize,
                height: Theme.Accounts.accountImageSize
            )
    }
    
    func remoteImage(_ imageUrl: URL) -> some View {
        Image.cachedURL(imageUrl)
            .resizable()
            .frame(
                width: Theme.Accounts.accountImageSize,
                height: Theme.Accounts.accountImageSize
            )
            .aspectRatio(contentMode: .fit)
    }
    
    func accountCard(_ account: Account) -> some View {
        HStack {
            if !account.image.isEmpty,
               let imageUrl = URL(string: account.image) {
                remoteImage(imageUrl)
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
    AccountsView<MockAccountsViewModel>()
        .environmentObject(MockAccountsViewModel())
}
