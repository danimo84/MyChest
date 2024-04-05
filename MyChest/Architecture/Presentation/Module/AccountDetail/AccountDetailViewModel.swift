//
//  AccountDetailViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import Combine

enum DomainProtocol: String, CaseIterable {
    
    case http = "http://"
    case https = "https://"
}

protocol AccountDetailViewModel: ObservableObject, Alertable {
    var isPresented: Bool { get }
    var isPassConfigSheetPresented: Bool { get set }
    var account: Account { get set }
    var newAccount: Bool { get set }
    var isPasswordEditable: Bool { get set }
    var isPasswordSecured: Bool { get set }
    var config: Config { get set }
    var isSaveButtonDisabled: Bool { get set }
    var isMetadataLoading: Bool { get set }
    var domainProtocol: DomainProtocol { get set }
    
    func saveNewAccount()
    func deleteAccount()
    func generatePassword()
    func paswordUpdated()
    func showAlert(_ forType: AlertType)
    func updateLinkMetadata()
}

final class AccountDetailViewModelDefault {
    
    var isPresented: Bool = true
    @Published var isPassConfigSheetPresented: Bool = false
    @Published var account: Account = .empty() {
        didSet {
            if account.comment.count > maxCommentCharacters {
                account.comment = String(account.comment.prefix(maxCommentCharacters))
            }
            isSaveButtonDisabled = account.domain.isEmpty || account.user.isEmpty || account.password.isEmpty
            if !newAccount {
                updateAccountInteractor.execute(account)
            }
        }
    }
    @Published var newAccount: Bool = false
    @Published var isPasswordEditable: Bool = false
    @Published var isPasswordSecured: Bool = true
    @Published var config: Config = .defaultConfig() {
        didSet {
            updateConfigInteractor.execute(config)
        }
    }
    @Published var isSaveButtonDisabled: Bool = true
    @Published var alertIsVisible: Bool = false
    @Published var alertViewModel: AlertViewModel = .empty()
    @Published var isMetadataLoading: Bool = false
    @Published var domainProtocol: DomainProtocol = .http
    private var subscriptions = Set<AnyCancellable>()
    
    private let maxCommentCharacters = Theme.AccountDetail.maxAccountCommentCharacters
    private let createNewAccountInteractor: CreateNewAccountInteractor
    private let deleteAccountInteractor: DeleteAccountInteractor
    private let updateAccountInteractor: UpdateAccountInteractor
    private let updateRememberPasswordNotificationInteractor: UpdateRememberPasswordNotificationInteractor
    private let getLinkMetadataInteractor: GetLinkMetadataInteractor
    private let getConfigInteractor: GetConfigInteractor
    private let updateConfigInteractor: UpdateConfigInteractor
    private let generatePasswordInteractor: GeneratePasswordInteractor
    
    init(
        originalAccount: Account?,
        createNewAccountInteractor: CreateNewAccountInteractor,
        deleteAccountInteractor: DeleteAccountInteractor,
        updateAccountInteractor: UpdateAccountInteractor,
        updateRememberPasswordNotificationInteractor: UpdateRememberPasswordNotificationInteractor,
        getLinkMetadataInteractor: GetLinkMetadataInteractor,
        getConfigInteractor: GetConfigInteractor,
        updateConfigInteractor: UpdateConfigInteractor,
        generatePasswordInteractor: GeneratePasswordInteractor
    ) {
        if let originalAccount { account = originalAccount }
        newAccount = originalAccount == nil ? true : false
        isPasswordEditable = originalAccount == nil ? true : false
        self.createNewAccountInteractor = createNewAccountInteractor
        self.deleteAccountInteractor = deleteAccountInteractor
        self.updateAccountInteractor = updateAccountInteractor
        self.updateRememberPasswordNotificationInteractor = updateRememberPasswordNotificationInteractor
        self.getLinkMetadataInteractor = getLinkMetadataInteractor
        self.getConfigInteractor = getConfigInteractor
        self.updateConfigInteractor = updateConfigInteractor
        self.generatePasswordInteractor = generatePasswordInteractor
        initDomainProtocol()
        Task { await fetchConfig() }
    }
}

extension AccountDetailViewModelDefault: AccountDetailViewModel {
    
    func saveNewAccount() {
        createNewAccountInteractor.execute(account: account)
    }
    
    func deleteAccount() {
        deleteAccountInteractor.execute(withId: account.id)
    }
    
    func generatePassword() {
        account.password = generatePasswordInteractor.execute(config)
    }
    
    func paswordUpdated() {
        account.updatedAt = .now
        updateRememberPasswordNotificationInteractor.execute(account: account)
    }
    
    func showAlert(_ type: AlertType) {
        configAlertViewModel(type)
    }
    
    func updateLinkMetadata() {
        account.domainProtocol = domainProtocol.rawValue
        Task { await requestLinkMetada() }
    }
}

private extension AccountDetailViewModelDefault {
    
    @MainActor
    func requestLinkMetada() async {
        #warning("TODO: Try to remove islaoding = false ????")
        isMetadataLoading = false
        subscriptions.removeAll()
        isMetadataLoading = true
        do {
            let metadata = try await getLinkMetadataInteractor.execute(forUrl: "\(domainProtocol.rawValue)\(account.domain)").async()
            account.image = metadata.imageUrl ?? ""
        } catch {
            account.image = ""
        }
        isMetadataLoading = false
    }
    
    func initDomainProtocol() {
        if newAccount {
            account.domainProtocol = domainProtocol.rawValue
        } else {
            self.domainProtocol = .init(rawValue: account.domainProtocol) ?? .http
        }
    }
}

private extension AccountDetailViewModelDefault {
    
    @MainActor 
    func fetchConfig() async {
        do {
            config = try await getConfigInteractor.execute().async()
        } catch {
            #warning("TODO: handle error with alert")
            print("Error: \(error)")
        }
    }
}

private extension AccountDetailViewModelDefault {
    
    func configAlertViewModel(_ type: AlertType) {
        alertViewModel = AlertViewModel(
            alertType: type,
            dismissAction: {
                self.alertIsVisible = false
            },
            confirmAction: {
                switch type {
                case .deleteConfirmation:
                    self.deleteAccount()
                    self.isPresented = false
                default:
                    break
                }
                self.alertIsVisible = false
            }
        )
    }
}
