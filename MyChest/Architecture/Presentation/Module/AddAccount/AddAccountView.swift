//
//  AddAccountView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import SwiftUI
import UniformTypeIdentifiers
import UIKit

struct AddAccountView<ViewModel: AddAccountViewModel>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var isUrlAlertPresented: Bool = false
    @State var isPassConfigSheetPresented: Bool = false
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        HStack {
                            TextField("Sitio web", text: $viewModel.account.domain)
                            VStack {
                                if !viewModel.account.image.isEmpty, let imageUrl = URL(string: viewModel.account.image) {
                                    Image.cachedURL(imageUrl)
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                        .aspectRatio(contentMode: .fit)
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 36, height: 36)
                                }
                            }
                            .onTapGesture {
                                isUrlAlertPresented = true
                            }
                        }
                    } header: {
                        if !viewModel.account.domain.isEmpty {
                            Text("Sitio web")
                        }
                    }
                    
                    Section {
                        TextField("Usuario", text: $viewModel.account.user)
                    } header: {
                        if !viewModel.account.user.isEmpty {
                            Text("Usuario")
                        }
                    }
                    Section {
                        if viewModel.isPasswordSecured {
                            SecureField("Contraseña", text: $viewModel.account.password)
                                .listRowSeparator(.hidden)
                                .disabled(!viewModel.isPasswordEditable)
                                .background(viewModel.isPasswordEditable ? Color(.systemBackground) : .gray)
                        } else {
                            TextField("Contraseña", text: $viewModel.account.password)
                                .listRowSeparator(.hidden)
                                .disabled(!viewModel.isPasswordEditable)
                                .background(viewModel.isPasswordEditable ? Color(.systemBackground) : .gray)
                        }
                        HStack {
                            Button {
                                copyPasswordToClipboard()
                            } label: {
                                Image(systemName: "doc.on.doc")
                                    .frame(height: 30)
                            }
                            .buttonStyle(.bordered)
                            Button {
                                viewModel.isPasswordEditable.toggle()
                            } label: {
                                viewModel.isPasswordEditable ? Image(systemName: "lock").frame(height: 30) : Image(systemName: "lock.open").frame(height: 30)
                            }
                            .buttonStyle(.bordered)
                            Button {
                                viewModel.isPasswordSecured.toggle()
                            } label: {
                                viewModel.isPasswordSecured ? Image(systemName: "eye").frame(height: 30) : Image(systemName: "eye.slash").frame(height: 30)
                            }
                            .buttonStyle(.bordered)
                            if viewModel.isPasswordEditable {
                                Spacer()
                                Button {
                                    isPassConfigSheetPresented = true
                                } label: {
                                    Image(systemName: "gearshape")
                                        .frame(height: 30)
                                }
                                .buttonStyle(.bordered)
                                Button {
                                    viewModel.generatePassword()
                                } label: {
                                    Text("Generar")
                                        .frame(height: 30)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    } header: {
                        if !viewModel.account.password.isEmpty {
                            Text("Contraseña")
                        }
                    }
                    
                    Section {
                        Picker("Recordar actualizar", selection: $viewModel.account.rememberUpdateMonths) {
                            ForEach(0..<25) { index in
                                if index == 0 {
                                    Text("Nunca")
                                        .tag(index)
                                } else {
                                    Text("Cada \(index) \(index != 1 ? "meses" : "mes")")
                                        .tag(index)
                                }
                            }
                        }
                    }
                    
                    Section {
                        TextEditor(text: $viewModel.account.comment)
                    } header: {
                        HStack {
                            Text("Notas")
                            Text("(\(viewModel.account.comment.count)/\(Constants.Accounts.maxAccountCommentCharacters))")
                                .foregroundStyle(viewModel.account.comment.count >= Constants.Accounts.maxAccountCommentCharacters ? .red : .gray)
                        }
                    }
                }
            }
            .navigationTitle("Add Account")
            .toolbar {
                if viewModel.newAccount {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            isPresented.toggle()
                        } label: {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.saveNewAccount()
                            isPresented.toggle()
                        } label: {
                            Text("Save")
                        }
                        .disabled(viewModel.isSaveButtonDisabled())
                    }
                } else {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            viewModel.deleteAccount()
                            isPresented.toggle()
                        } label: {
                            Text("Eliminar")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .sheet(isPresented: $isPassConfigSheetPresented, content: {
                NavigationStack {
                    List {
                        Section {
                            Picker("Número de caracteres", selection: $viewModel.config.charactersNumber) {
                                ForEach(Constants.PasswordGenerator.minChars..<Constants.PasswordGenerator.maxChars, id: \.self) { index in
                                    Text("\(index)")
                                        .tag(index)
                                }
                            }
                            Toggle("Mayúsculas", isOn: $viewModel.config.requireUpper)
                            Toggle("Minúsculas", isOn: $viewModel.config.requireLower)
                            Toggle("Números", isOn: $viewModel.config.requireNumber)
                            Toggle("Especiales", isOn: $viewModel.config.requireSpecialCharacter)
                        }
                    }
                    .navigationTitle("Generador de contraseñas")
                }
                .presentationDetents([.medium])
            })
            .alert("Añade tu imagen.", isPresented: $isUrlAlertPresented) {
                TextField("Image URL", text: $viewModel.account.image)
                Button("Aceptar") {
                    isUrlAlertPresented = false
                }
            } message: {
                Text("Customiza la imagen de esta cuenta añadiendo la url de la misma.")
            }
        }
    }
    
    private func copyPasswordToClipboard() {
        UIPasteboard.general.setValue(viewModel.account.password, forPasteboardType: UTType.plainText.identifier)
    }
}

#Preview {
    AddAccountView<MockAddAccountViewModel>(isPresented: .constant(true))
        .environmentObject(MockAddAccountViewModel())
        .modelContainer(for: Account.self)
}
