//
//  AccountDetailViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftData

protocol AccountDetailViewModel: ObservableObject, Alertable {
    var isPresented: Bool { get }
    var isPassConfigSheetPresented: Bool { get set }
    var account: Account { get set }
    var newAccount: Bool { get set }
    var isPasswordEditable: Bool { get set }
    var isPasswordSecured: Bool { get set }
    var config: Config { get set }
    var isSaveButtonDisabled: Bool { get set }
    
    func saveNewAccount()
    func deleteAccount()
    func fetchConfig()
    func generatePassword()
    func paswordUpdated()
    func configAlertViewModel(_ forType: AlertType)
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
    
    private let accountRepository: AccountRepository
    private let configRepository: ConfigRepository
    private let notificationRepository: LocalNotificationRepository
    private let passordGenerator: PasswordGeneratorManager
    private let notificationsManager: NotificationsManager
    
    init(
        originalAccount: Account?,
        accountRepository: AccountRepository,
        configRepository: ConfigRepository,
        notificationRepository: LocalNotificationRepository,
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
        self.passordGenerator = passordGenerator
        self.notificationsManager = notificationsManager
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
    
    func fetchConfig() {
        config = configRepository.fetchConfig()
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
