//
//  AccountDetailView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import SwiftUI
import UIKit

struct AccountDetailView<Presenter: AccountDetailPresenter>: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var presenter: Presenter
    
    var body: some View {
        NavigationStack {
            VStack {
                accountForm
            }
            .navigationTitle(
                presenter.newAccount
                ? Strings.AccountDetailScreen.newAccountDetailTitle
                : Strings.AccountDetailScreen.accountDetailTitle
            )
            .toolbar(
                .accountDetail(forNewAccount: presenter.newAccount),
                tralingButtonDisabled: $presenter.isSaveButtonDisabled,
                action: {
                    handleToolbarAction($0)
                }
            )
            .sheet(isPresented: $presenter.isPassConfigSheetPresented, content: {
                passwordConfigSheet
            })
            .alert(
                isPresented: $presenter.alertIsVisible,
                viewModel: $presenter.alertViewModel,
                bindableString: $presenter.account.image
            )
            .onChange(of: presenter.isPresented) {
                if !presenter.isPresented {
                    dismiss()
                }
            }
        }
    }
    
    var accountForm: some View {
        Form {
            AccountDetailDomainSection(
                viewModel: presenter,
                isUrlAlertPresented: $presenter.alertIsVisible
            )
            AccountDetailUserSection(viewModel: presenter)
            AccountDetailPasswordSection(
                viewModel: presenter,
                isPresented: $presenter.isPassConfigSheetPresented
            )
            AccountDetailRememberUpdatePasswordSection(viewModel: presenter)
            AccountDetailNotesSection(viewModel: presenter)
            lastPasswordUpdatedDate
        }
    }
    
    var passwordConfigSheet: some View {
        NavigationStack {
            List {
                PasswordGeneratorSettings(
                    charactersNumber: $presenter.config.charactersNumber,
                    requireUpper: $presenter.config.requireUpper,
                    requireLower: $presenter.config.requireLower,
                    requireNumber: $presenter.config.requireNumber,
                    requireSpecialCharacter: $presenter.config.requireSpecialCharacter,
                    showHeader: false
                )
            }
            .navigationTitle(Strings.AccountDetailScreen.passwordGeneratorTitle)
        }
        .presentationDetents([.medium])
    }
    
    var lastPasswordUpdatedDate: some View {
        HStack {
            Text(Strings.AccountDetailScreen.lastPasswordUpdatedDate)
                .font(Theme.Font.caption)
            Spacer()
            Text(presenter.account.updatedAt.description
            )
            .font(Theme.Font.footnote)
        }
    }
    
    private func handleToolbarAction(_ action: ToolbarButton) {
        switch action {
        case .cancel:
            dismiss()
        case .delete:
            presenter.showAlert(.deleteConfirmation(.account))
            presenter.alertIsVisible = true
        case .save:
            presenter.saveNewAccount()
            dismiss()
        default:
            return
        }
    }
}

#Preview {
    AccountDetailView<MockAccountDetailPresenter>(presenter: MockAccountDetailPresenter())
        .modelContainer(for: AccountEntityCache.self)
}
