//
//  AccountDetailViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
//import SwiftData
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
    func configAlertViewModel(_ forType: AlertType)
    func updateLinkMetadata()
}

final class AccountDetailViewModelDefault: AccountDetailViewModel {
    
    let maxCommentCharacters = Theme.AccountDetail.maxAccountCommentCharacters
    
    var isPresented: Bool = true
    @Published var isPassConfigSheetPresented: Bool = false
    @Published var account: Account = .empty() {
        didSet {
            if account.comment.count > maxCommentCharacters {
                account.comment = String(account.comment.prefix(maxCommentCharacters))
            }
            isSaveButtonDisabled = account.domain.isEmpty || account.user.isEmpty || account.password.isEmpty
        }
    }
    
    @Published var newAccount: Bool = false
    @Published var isPasswordEditable: Bool = false
    @Published var isPasswordSecured: Bool = true
    @Published var config: Config = .defaultConfig()
    @Published var isSaveButtonDisabled: Bool = true
    @Published var alertIsVisible: Bool = false
    @Published var alertViewModel: AlertViewModel = .empty()
    @Published var isMetadataLoading: Bool = false
    @Published var domainProtocol: DomainProtocol = .http
    
    private var subscriptions = Set<AnyCancellable>()
    
    private let accountRepository: AccountRepository
    private let configRepository: ConfigRepository
    private let notificationRepository: LocalNotificationRepository
    private let linkMetadaRepository: LinkMetadataRepository
    private let passordGenerator: PasswordGeneratorManager
    private let notificationsManager: NotificationsManager
    
    init(
        originalAccount: Account?,
        accountRepository: AccountRepository,
        configRepository: ConfigRepository,
        notificationRepository: LocalNotificationRepository,
        linkMetadaRepository: LinkMetadataRepository,
        passordGenerator: PasswordGeneratorManager,
        notificationsManager: NotificationsManager
    ) {
        if let originalAccount {
            account = originalAccount
        }
        newAccount = originalAccount == nil ? true : false
        isPasswordEditable = originalAccount == nil ? true : false
        self.accountRepository = accountRepository
        self.configRepository = configRepository
        self.notificationRepository = notificationRepository
        self.linkMetadaRepository = linkMetadaRepository
        self.passordGenerator = passordGenerator
        self.notificationsManager = notificationsManager
        initDomainProtocol()
        fetchConfig()
    }
    
    func saveNewAccount() {
        accountRepository.inserAccount(account)
        scheduleNotification()
    }
    
    func deleteAccount() {
        accountRepository.removeAccount(account)
        notificationRepository.removeNotificationsWithAccountId(account.id)
    }
    
    func generatePassword() {
        account.password = passordGenerator.generatePasswordWithConfig(config)
    }
    
    func paswordUpdated() {
        account.updatedAt = .now
        cancelPendingNotificationForAccount()
        notificationRepository.removePendingNotificationsWithAccountId(account.id)
        scheduleNotification()
    }
    
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
    
    func updateLinkMetadata() {
        account.domainProtocol = domainProtocol.rawValue
        requestLinkMetada()
    }
}

private extension AccountDetailViewModelDefault {
    
    func requestLinkMetada() {
        isMetadataLoading = false
        subscriptions.removeAll()
        isMetadataLoading = true
        
        print("Account domain-> \(domainProtocol.rawValue)\(account.domain)")
        linkMetadaRepository.getLinkMetadata(forUrl: "\(domainProtocol.rawValue)\(account.domain)")
            .sink(
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        self.isMetadataLoading = false
                        self.account.image = ""
                        
                        print("Error-> \(error)")
                    }
                },
                receiveValue: { metadata in
                    print("Metadata-> \(metadata)")
                    self.isMetadataLoading = false
                    self.account.image = metadata.imageUrl ?? ""
                }
            )
            .store(in: &subscriptions)
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
    
    func fetchConfig() {
        config = configRepository.fetchConfig()
    }
}

private extension AccountDetailViewModelDefault {
    
    func cancelPendingNotificationForAccount() {
        notificationsManager.cancelPendingNotificationWithAccountId(account.id)
    }
    
    func scheduleNotification() {
        guard account.rememberUpdateMonths != .zero,
        let notification = buildNotification(account: account) else {
            return
        }
        notificationsManager.scheduleNotifications([notification])
        saveNotification(notification)
    }
    
    func buildNotification(account: Account) -> LocalNotification? {
        .buildLocalNotificationForAccount(account)
    }
    
    func saveNotification(_ notification: LocalNotification) {
        notificationRepository.insertNotification(notification)
    }
}
