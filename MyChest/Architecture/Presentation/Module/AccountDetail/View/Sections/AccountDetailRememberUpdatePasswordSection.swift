//
//  AccountDetailRememberUpdatePasswordSection.swift
//  MyChest
//
//  Created by Daniel Moraleda on 9/3/24.
//

import SwiftUI

struct AccountDetailRememberUpdatePasswordSection<ViewModel: AccountDetailViewModel>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        Section {
            Picker(
                Strings.AccountDetailScreen.rememberUpdatePasswordTitle,
                selection: $viewModel.account.rememberUpdateMonths
            ) {
                pickerItems
            }
        }
    }
    
    var pickerItems: some View {
        ForEach(0..<25) {
            $0 == 0
            ? Text(Strings.AccountDetailScreen.rememberUpdatePasswordNever)
                .tag($0)
            : Text($0 == 1
                   ? Strings.AccountDetailScreen.rememberUpdatePasswordByMonth(monthsNumber: $0)
                   : Strings.AccountDetailScreen.rememberUpdatePasswordByMonths(monthsNumber: $0)
            )
            .tag($0)
        }
    }
}

#Preview {
    AccountDetailRememberUpdatePasswordSection(viewModel: MockAccountDetailViewModel())
}
