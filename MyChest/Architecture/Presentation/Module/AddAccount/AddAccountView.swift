//
//  AddAccountView.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import SwiftUI

struct AddAccountView<ViewModel: AddAccountViewModel>: View {
    
    @EnvironmentObject var viewModel: ViewModel
    @State var path: NavigationPath = .init()
    @State var isUrlAlertPresented: Bool = false
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack(path: $path) {
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
                        TextField("Contraseña", text: $viewModel.account.password)
                            .listRowSeparator(.hidden)
                        HStack {
                            Button {
                                
                            } label: {
                                Text("Opciones")
                            }
                            .buttonStyle(.bordered)
                            Spacer()
                            Button {
                                
                            } label: {
                                Text("Generar")
                            }
                            .buttonStyle(.bordered)
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
                                } else {
                                    Text("Cada \(index) \(index != 1 ? "meses" : "mes")")
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
}

#Preview {
    AddAccountView<MockAddAccountViewModel>(isPresented: .constant(true))
        .environmentObject(MockAddAccountViewModel())
        .modelContainer(for: Account.self)
}
