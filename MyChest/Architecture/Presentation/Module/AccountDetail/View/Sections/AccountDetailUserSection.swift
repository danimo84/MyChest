//
//  AccountDetailUserSection.swift
//  MyChest
//
//  Created by Daniel Moraleda on 9/3/24.
//

import SwiftUI

struct AccountDetailUserSection<ViewModel: AccountDetailPresenter>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Section {
            TextField(Strings.AccountDetailScreen.userSectionPlaceholder, text: $viewModel.account.user)
        } header: {
            if !viewModel.account.user.isEmpty {
                Text(Strings.AccountDetailScreen.userSectionPlaceholder)
            }
        }
    }
}

#Preview {
    AccountDetailUserSection(viewModel: MockAccountDetailPresenter())
}
