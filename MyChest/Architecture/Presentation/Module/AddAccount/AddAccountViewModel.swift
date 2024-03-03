//
//  AddAccountViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/1/24.
//

import Foundation
import SwiftData

protocol AddAccountViewModel: ObservableObject {
    var account: Account { get set }
    var newAccount: Bool { get set }
    var isPasswordEditable: Bool { get set }
    var isPasswordSecured: Bool { get set }
    var config: Config { get set }
    
    func isSaveButtonDisabled() -> Bool
    func saveNewAccount()
    func deleteAccount()
    func fetchConfig()
    func generatePassword()
    func paswordUpdated()
}

final class AddAccountViewModelDefault: AddAccountViewModel {
    
    let maxCommentCharacters = Constants.Accounts.maxAccountCommentCharacters
    
    @Published var account: Account = .empty() {
        didSet {
            if account.comment.count > maxCommentCharacters {
                account.comment = String(account.comment.prefix(maxCommentCharacters))
            }
        }
    }
    
    @Published var newAccount: Bool = false
    @Published var isPasswordEditable: Bool = false
    @Published var isPasswordSecured: Bool = true
    @Published var config: Config = .defaultConfig()
    
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
    
    func isSaveButtonDisabled() -> Bool {
        account.domain.isEmpty || account.user.isEmpty || account.password.isEmpty
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

private extension AddAccountViewModelDefault {
    
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
    
    // TODO: find other best place ¿in model like empty or mock?
    func buildNotification(account: Account) -> LocalNotification? {
        guard let date = Calendar.current.date(byAdding: .second, value: account.rememberUpdateMonths * 10, to: .now) else {
            return nil
        }
        return .init(
            id: UUID().uuidString,
            accountId: account.id,
            title: "Cambio de contraseña",
            body: "La contraseña para el dominio \(account.domain) debe ser actualizada. Han pasado \(account.rememberUpdateMonths) meses",
            datetime: date,
            repeats: false,
            createdAt: .now,
            updatedAt: .now,
            isReaded: false
        )
    }
    
    func saveNotification(_ notification: LocalNotification) {
        notificationRepository.insertNotification(notification)
    }
}
