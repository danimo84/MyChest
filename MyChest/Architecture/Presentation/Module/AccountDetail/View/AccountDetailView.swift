//
//  AccountDetailView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import SwiftUI
import UIKit

struct AccountDetailView<ViewModel: AccountDetailViewModel>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var isUrlAlertPresented: Bool = false
    @State var isDeleteConfirmationAlertPresented: Bool = false
    @State var isPassConfigSheetPresented: Bool = false
    @Binding var isPresented: Bool
    
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
            .sheet(isPresented: $isPassConfigSheetPresented, content: {
                passwordConfigSheet
            })
            .alert(Strings.AccountDetailScreen.addYourImageAlertTitle, isPresented: $isUrlAlertPresented) {
                TextField(Strings.AccountDetailScreen.addYourImageAlertPlaceholder, text: $viewModel.account.image)
                Button(Strings.AccountDetailScreen.addYourImageAlertAcceptButton) {
                    isUrlAlertPresented = false
                }
            } message: {
                Text(Strings.AccountDetailScreen.addYourImageAlertMessage)
            }
            .alert(Strings.AccountDetailScreen.deleteAccountAlertTitle, isPresented: $isDeleteConfirmationAlertPresented) {
                Button(Strings.AccountDetailScreen.deleteAccountAlertAcceptButton, role: .destructive) {
                    isUrlAlertPresented = false
                    viewModel.deleteAccount()
                    isPresented.toggle()
                }
            } message: {
                Text(Strings.AccountDetailScreen.deleteAccountAlertMessage)
            }
        }
    }
    
    var accountForm: some View {
        Form {
            AccountDetailDomainSection(
                viewModel: viewModel,
                isUrlAlertPresented: $isUrlAlertPresented
            )
            AccountDetailUserSection(viewModel: viewModel)
            AccountDetailPasswordSection(
                viewModel: viewModel,
                isPassConfigSheetPresented: $isPassConfigSheetPresented
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
            isPresented.toggle()
        case .delete:
            isDeleteConfirmationAlertPresented = true
        case .save:
            viewModel.saveNewAccount()
            isPresented.toggle()
        default:
            return
        }
    }
}

#Preview {
    AccountDetailView<MockAccountDetailViewModel>(isPresented: .constant(true))
        .environmentObject(MockAccountDetailViewModel())
        .modelContainer(for: Account.self)
}
