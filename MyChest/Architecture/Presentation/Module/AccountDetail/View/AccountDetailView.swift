//
//  AccountDetailView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import SwiftUI
import UIKit

struct AccountDetailView<ViewModel: AccountDetailPresenter>: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                accountForm
            }
            .navigationTitle(
                viewModel.newAccount
                ? Strings.AccountDetailScreen.newAccountDetailTitle
                : Strings.AccountDetailScreen.accountDetailTitle
            )
            .toolbar(
                .accountDetail(forNewAccount: viewModel.newAccount),
                tralingButtonDisabled: $viewModel.isSaveButtonDisabled,
                action: {
                    handleToolbarAction($0)
                }
            )
            .sheet(isPresented: $viewModel.isPassConfigSheetPresented, content: {
                passwordConfigSheet
            })
            .alert(
                isPresented: $viewModel.alertIsVisible,
                viewModel: $viewModel.alertViewModel,
                bindableString: $viewModel.account.image
            )
            .onChange(of: viewModel.isPresented) {
                if !viewModel.isPresented {
                    dismiss()
                }
            }
        }
    }
    
    var accountForm: some View {
        Form {
            AccountDetailDomainSection(
                viewModel: viewModel,
                isUrlAlertPresented: $viewModel.alertIsVisible
            )
            AccountDetailUserSection(viewModel: viewModel)
            AccountDetailPasswordSection(
                viewModel: viewModel,
                isPresented: $viewModel.isPassConfigSheetPresented
            )
            AccountDetailRememberUpdatePasswordSection(viewModel: viewModel)
            AccountDetailNotesSection(viewModel: viewModel)
            lastPasswordUpdatedDate
        }
    }
    
    var passwordConfigSheet: some View {
        NavigationStack {
            List {
                PasswordGeneratorSettings(
                    charactersNumber: $viewModel.config.charactersNumber,
                    requireUpper: $viewModel.config.requireUpper,
                    requireLower: $viewModel.config.requireLower,
                    requireNumber: $viewModel.config.requireNumber,
                    requireSpecialCharacter: $viewModel.config.requireSpecialCharacter,
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
            Text(viewModel.account.updatedAt.description
            )
            .font(Theme.Font.footnote)
        }
    }
    
    private func handleToolbarAction(_ action: ToolbarButton) {
        switch action {
        case .cancel:
            dismiss()
        case .delete:
            viewModel.showAlert(.deleteConfirmation(.account))
            viewModel.alertIsVisible = true
        case .save:
            viewModel.saveNewAccount()
            dismiss()
        default:
            return
        }
    }
}

#Preview {
    AccountDetailView<MockAccountDetailPresenter>()
        .environmentObject(MockAccountDetailPresenter())
        .modelContainer(for: AccountEntityCache.self)
}
