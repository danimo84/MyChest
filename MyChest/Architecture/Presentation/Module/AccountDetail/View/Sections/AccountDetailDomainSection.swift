//
//  AccountDetailDomainSection.swift
//  MyChest
//
//  Created by Daniel Moraleda on 9/3/24.
//

import SwiftUI

struct AccountDetailDomainSection<ViewModel: AccountDetailViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    @Binding var isUrlAlertPresented: Bool
    
    var body: some View {
        Section {
            HStack {
                domainTextField
                domainImage
            }
        } header: {
            if !viewModel.account.domain.isEmpty {
                header
            }
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
            if !viewModel.account.image.isEmpty,
               let imageUrl = URL(string: viewModel.account.image) {
                remoteImage(imageUrl)
            } else {
                defaultImage
            }
        }
        .onTapGesture {
            isUrlAlertPresented = true
        }
    }
    
    var defaultImage: some View {
        Image(systemName: Assets.SystemImage.photo)
            .resizable()
            .frame(
                width: Theme.AccountDetail.accountImageSize,
                height: Theme.AccountDetail.accountImageSize
            )
    }
    
    private func remoteImage(_ imageUrl: URL) -> some View {
        Image.cachedURL(imageUrl)
            .resizable()
            .frame(
                width: Theme.AccountDetail.accountImageSize,
                height: Theme.AccountDetail.accountImageSize
            )
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    AccountDetailDomainSection(
        viewModel: MockAccountDetailViewModel(),
        isUrlAlertPresented: .constant(false)
    )
}

