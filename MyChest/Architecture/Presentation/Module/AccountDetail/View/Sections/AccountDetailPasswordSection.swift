//
//  AccountDetailPasswordSection.swift
//  MyChest
//
//  Created by Daniel Moraleda on 9/3/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct AccountDetailPasswordSection<ViewModel: AccountDetailPresenter>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        Section {
            passwordFied
            passwordOptions
        } header: {
            if !viewModel.account.password.isEmpty {
                Text(Strings.AccountDetailScreen.passwordSectionHeader)
            }
        }
        .onChange(of: viewModel.account.password) {
            viewModel.paswordUpdated()
        }
    }
    
    var passwordFied: some View {
        VStack {
            if viewModel.isPasswordSecured {
                SecureField(Strings.AccountDetailScreen.passwordSectionPlaceholder, text: $viewModel.account.password)
            } else {
                TextField(Strings.AccountDetailScreen.passwordSectionPlaceholder, text: $viewModel.account.password)
            }
        }
        .listRowSeparator(.hidden)
        .disabled(!viewModel.isPasswordEditable)
        .background(viewModel.isPasswordEditable ? Color(.systemBackground) : .gray)
    }
    
    var passwordOptions: some View {
        HStack {
            copyButton
            lockUnlockButton
            showHideButton
            if viewModel.isPasswordEditable {
                Spacer()
                passwordSettingsButton
                generatePasswordButton
            }
        }
    }
    
    var copyButton: some View {
        Button {
            copyPasswordToClipboard()
        } label: {
            Image(systemName: Assets.SystemImage.docOnDoc)
                .frame(height: Theme.AccountDetail.passwordButtonsHeight)
        }
        .buttonStyle(.bordered)
    }
    
    var lockUnlockButton: some View {
        Button {
            viewModel.isPasswordEditable.toggle()
        } label: {
            viewModel.isPasswordEditable 
            ? Image(systemName: Assets.SystemImage.lock)
                .frame(height: Theme.AccountDetail.passwordButtonsHeight)
            : Image(systemName: Assets.SystemImage.lockOpened)
                .frame(height: Theme.AccountDetail.passwordButtonsHeight)
        }
        .buttonStyle(.bordered)
    }
    
    var showHideButton: some View {
        Button {
            viewModel.isPasswordSecured.toggle()
        } label: {
            viewModel.isPasswordSecured 
            ? Image(systemName: Assets.SystemImage.eye)
                .frame(height: Theme.AccountDetail.passwordButtonsHeight)
            : Image(systemName: Assets.SystemImage.eyeSlash)
                .frame(height: Theme.AccountDetail.passwordButtonsHeight)
        }
        .buttonStyle(.bordered)
    }
    
    var passwordSettingsButton: some View {
        Button {
            isPresented = true
        } label: {
            Image(systemName: Assets.SystemImage.gearshape)
                .frame(height: Theme.AccountDetail.passwordButtonsHeight)
        }
        .buttonStyle(.bordered)
    }
    
    var generatePasswordButton: some View {
        Button {
            viewModel.generatePassword()
        } label: {
            Text(Strings.AccountDetailScreen.passwordSectionGenerateButton)
                .frame(height: Theme.AccountDetail.passwordButtonsHeight)
        }
        .buttonStyle(.bordered)
    }
    
    private func copyPasswordToClipboard() {
        UIPasteboard.general.setValue(viewModel.account.password, forPasteboardType: UTType.plainText.identifier)
    }
}

#Preview {
    AccountDetailPasswordSection(
        viewModel: MockAccountDetailPresenter(),
        isPresented: .constant(false)
    )
}
