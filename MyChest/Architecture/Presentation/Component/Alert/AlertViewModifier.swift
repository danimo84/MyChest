//
//  AlertViewModifier.swift
//  MyChest
//
//  Created by Daniel Moraleda on 14/3/24.
//

import SwiftUI

extension View {
    
    func alert(
        isPresented: Binding<Bool>,
        viewModel: Binding<AlertViewModel>,
        bindableString: Binding<String>? = nil
    ) -> some View {
        modifier(
            AlertViewModifier(
                isPresented: isPresented,
                viewModel: viewModel,
                bindableString: bindableString
            )
        )
    }
}

struct AlertViewModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    @Binding var viewModel: AlertViewModel
    var bindableString: Binding<String>?
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .alert(
                    viewModel.alertType.title,
                    isPresented: $isPresented
                ) {
                    switch viewModel.alertType {
                    case .genericError, .customError(_, _):
                        error
                    case .deleteConfirmation:
                        deleteConfirmation
                    case .inputData:
                        inputData
                    }
                } message: {
                    Text(viewModel.alertType.message)
                }
        }
    }
    
    private var error: some View {
        Button(viewModel.alertType.dismissButtonTitle, role: .cancel, action: viewModel.dismissAction)
    }
    
    private var deleteConfirmation: some View {
        VStack {
            if let confirmAction = viewModel.confirmAction {
                Button(viewModel.alertType.confirmButtonTitle, role: .destructive, action: confirmAction)
            }
        }
    }
    
    private var inputData: some View {
        VStack {
            if let value = bindableString {
                TextField(viewModel.alertType.placeholder, text: value)
            }
            if let confirmAction = viewModel.confirmAction {
                Button(viewModel.alertType.confirmButtonTitle, action: confirmAction)
            }
        }
    }
}
