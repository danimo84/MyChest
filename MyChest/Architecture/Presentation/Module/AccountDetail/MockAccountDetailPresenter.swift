//
//  MockAccountDetailPresenter.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftData

final class MockAccountDetailPresenter: AccountDetailPresenter {
    
    var isPresented: Bool = true
    @Published var isPassConfigSheetPresented: Bool = false
    @Published var account: Account = .emptyMock()
    @Published var newAccount: Bool = false
    @Published var isPasswordEditable: Bool = false
    @Published var isPasswordSecured: Bool = false
    @Published var config: Config = .defaultConfig()
    @Published var isSaveButtonDisabled: Bool = false
    @Published var alertIsVisible: Bool = false
    @Published var alertViewModel: AlertViewModel = .empty()
    @Published var isMetadataLoading: Bool = false
    @Published var domainProtocol: DomainProtocol = .http
    
    func saveNewAccount() {
        // Intentionally empty
    }
    
    func deleteAccount() {
        // Intentionally empty
    }
    
    func generatePassword() {
        // Intentionally empty
    }
    
    func paswordUpdated() {
        // Intentionally empty
    }
    
    func showAlert(_ forType: AlertType) {
        // Intentionally empty
    }
    
    func updateLinkMetadata() {
        // Intentionally empty
    }
}
