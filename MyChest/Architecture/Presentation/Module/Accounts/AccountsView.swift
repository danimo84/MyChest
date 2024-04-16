//
//  AccountsView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 17/1/24.
//

import SwiftUI
import SwiftData

struct AccountsView<Presenter: AccountsPresenter>: View {
    
    @StateObject var presenter: Presenter
    
    var body: some View {
        NavigationStack {
            List {
                if presenter.accounts.isEmpty {
                    Text(Strings.AccountsScreen.emptyStateMessage)
                } else {
                    ForEach(presenter.accounts) {
                        accountCard($0)
                    }
                }
            }
            .navigationTitle(Strings.AccountsScreen.title)
            .toolbar(
                .accounts,
                action: {
                    if $0 == .add {
                        presenter.selectedAccount = nil
                        presenter.isAccountSheetPresented = true
                    }
                })
            .onChange(of: presenter.isAccountSheetPresented) {
                if !presenter.isAccountSheetPresented {
                    presenter.fetchAccounts()
                }
            }
            .onAppear {
                presenter.onAppear()
            }
        }
        .sheet(isPresented: $presenter.isAccountSheetPresented) {
            AccountDetailConfigurator().view(originalAccount: presenter.selectedAccount)
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
                width: Theme.Accounts.accountImageSize,
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
            presenter.selectedAccount = account
            presenter.isAccountSheetPresented = true
        }
        .swipeActions {
            Button(
                Strings.AccountsScreen.deletableButton,
                role: .destructive
            ) {
                presenter.deleteAccount(account)
            }
        }
    }
}

#Preview {
    AccountsView<MockAccountsPresenter>(presenter: MockAccountsPresenter())
}
