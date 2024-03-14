//
//  AccountDetailViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftData

protocol AccountDetailViewModel: ObservableObject {
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
}

final class AccountDetailViewModelDefault: AccountDetailViewModel {
    
    let maxCommentCharacters = Theme.AccountDetail.maxAccountCommentCharacters
    
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
