//
//  AccountDetailDomainSection.swift
//  MyChest
//
//  Created by Daniel Moraleda on 9/3/24.
//

import SwiftUI

struct AccountDetailDomainSection<ViewModel: AccountDetailPresenter>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Binding var isUrlAlertPresented: Bool
    
    var body: some View {
        Section {
            HStack {
                VStack {
                    domainPicker
                    domainTextField
                }
                HStack {
                    Spacer()
                    domainImage
                }
            }
        } header: {
            if !viewModel.account.domain.isEmpty {
                header
            }
        }
        .onChange(of: viewModel.account.domain) {
            viewModel.updateLinkMetadata()
        }
    }
    
    var domainPicker: some View {
        Picker("", selection: $viewModel.domainProtocol) {
            ForEach(Array(DomainProtocol.allCases), id: \.self) {
                Text($0.rawValue)
                    .tag($0)
            }
        }
        .pickerStyle(.palette)
        .onChange(of: viewModel.domainProtocol) {
            viewModel.updateLinkMetadata()
        }
    }
    
    var header: some View {
        Text(Strings.AccountDetailScreen.domainSectionHeader)
    }
    
    var domainTextField: some View {
        TextField(
            Strings.AccountDetailScreen.domainSectionPlaceholder,
            text: $viewModel.account.domain
        )
    }
    
    var domainImage: some View {
        VStack {
            if viewModel.isMetadataLoading {
                ProgressView()
            } else {
                if !viewModel.account.image.isEmpty {
                    remoteImage(viewModel.account.image)
                } else {
                    defaultImage
                }
            }
        }
        .onTapGesture {
            isUrlAlertPresented = true
            viewModel.showAlert(.inputData(.domain))
        }
    }
    
    private var defaultImage: some View {
        DefaultImage(
            viewModel: .init(
                width: Theme.AccountDetail.accountDefaultImageSize,
                height: Theme.AccountDetail.accountDefaultImageSize
            )
        )
    }
    
    private func remoteImage(_ imageUrl: String) -> some View {
        RemoteImage(
            viewModel: .init(
                width: Theme.AccountDetail.accountImageSize,
                height: Theme.AccountDetail.accountImageSize,
                cornerRadius: Theme.Radius.small,
                clipedShape: true,
                url: imageUrl
            )
        )
    }
}

#Preview {
    AccountDetailDomainSection(
        viewModel: MockAccountDetailPresenter(),
        isUrlAlertPresented: .constant(false)
    )
}

