//
//  AccountDetailNotesSection.swift
//  MyChest
//
//  Created by Daniel Moraleda on 9/3/24.
//

import SwiftUI

struct AccountDetailNotesSection<ViewModel: AccountDetailViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Section {
            TextEditor(text: $viewModel.account.comment)
        } header: {
            HStack {
                Text(Strings.AccountDetailScreen.notesSectionTitle)
                Text("(\(viewModel.account.comment.count)/\(Theme.AccountDetail.maxAccountCommentCharacters))")
                    .foregroundStyle(
                        viewModel.account.comment.count >= Theme.AccountDetail.maxAccountCommentCharacters
                        ? .red
                        : .gray
                    )
            }
        }
    }
}

#Preview {
    AccountDetailNotesSection(viewModel: MockAccountDetailViewModel())
}
