//
//  PokemonModule.swift
//  PokemonSwiftUI
//
//  Created by Daniel Moraleda on 20/10/23.
//

import Foundation
import Swinject

class MyChestModule: InjectorModule {
    
    override func configure(_ container: Container) {
        configureTabbar(container)
        configureAccounts(container)
        configureSettings(container)
        configureNotifications(container)
        configureUser(container)
        configureGeolocation(container)
    }
    
    private func configureTabbar(_ container: Container) {
        container.register(PermissionsManager.self) { _ in
            PermissionsManagerDefault()
        }
        .inObjectScope(.container)
        
        container.register(TryBiometricAuthInteractor.self) { r in
            TryBiometricAuthInteractorDefault(permissionManager: r.resolve(PermissionsManager.self)!)
        }
        .inObjectScope(.container)
        
        container.register(UpdateNotificationPermissionInteractor.self) { r in
            UpdateNotificationPermissionInteractorDefault(permissionManager: r.resolve(PermissionsManager.self)!)
        }
        .inObjectScope(.container)
        
        container.register(GetNotificationPermissionInteractor.self) { r in
            GetNotificationPermissionInteractorDefault(permissionManager: r.resolve(PermissionsManager.self)!)
        }
        .inObjectScope(.container)
        
        container.register(RequestNotificationPermissionIfNeededInteractor.self) { r in
            RequestNotificationPermissionIfNeededInteractorDefault(
                storageManager: StorageManager.shared,
                permissionManager: r.resolve(PermissionsManager.self)!
            )
        }
        .inObjectScope(.container)
    }
    
    private func configureAccounts(_ container: Container) {
        container.register(AccountLocalDataSource.self) { _ in
            AccountLocalDataSourceDefault()
        }
        .inObjectScope(.container)
        
        container.register(LinkMetadataRemoteDataSource.self) { _ in
            LinkMetadataRemoteDataSourceDefault()
        }
        .inObjectScope(.container)
        
        container.register(AccountRepository.self) { r in
            AccountRepositoryDefault(
                localDataSource: r.resolve(AccountLocalDataSource.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(LinkMetadataRepository.self) { r in
            LinkMetadataRepositoryDefault(
                remoteDataSource: r.resolve(LinkMetadataRemoteDataSource.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(GetAccountsInteractor.self) { r in
            GetAccountsInteractorDefault(accountRepository: r.resolve(AccountRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(CreateNewAccountInteractor.self) { r in
            CreateNewAccountInteractorDefault(
                accountRepository: r.resolve(AccountRepository.self)!,
                notificationRepository: r.resolve(LocalNotificationRepository.self)!,
                notificationsManager: r.resolve(NotificationsManager.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(DeleteAccountInteractor.self) { r in
            DeleteAccountInteractorDefault(
                accountRepository: r.resolve(AccountRepository.self)!,
                notificationRepository: r.resolve(LocalNotificationRepository.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(UpdateAccountInteractor.self) { r in
            UpdateAccountInteractorDefault(
                accountRepository: r.resolve(AccountRepository.self)!
            )
        }
        .inObjectScope(.container)

        container.register(GetLinkMetadataInteractor.self) { r in
            GetLinkMetadataInteractorDefault(
                linkMetadataRepository: r.resolve(LinkMetadataRepository.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(PasswordGeneratorManager.self) { _ in
            PasswordGeneratorManagerDefault()
        }
        .inObjectScope(.container)
        
        container.register(GeneratePasswordInteractor.self) { r in
            GeneratePasswordInteractorDefault(
                passwordGeneratorManager: r.resolve(PasswordGeneratorManager.self)!
            )
        }
        .inObjectScope(.container)
    }
    
    private func configureSettings(_ container: Container) {
        container.register(ConfigLocalDataSource.self) { _ in
            ConfigLocalDataSourceDefault()
        }
        .inObjectScope(.container)
        
        container.register(ConfigRepository.self) { r in
            ConfigRepositoryDefault(
                localDataSource: r.resolve(ConfigLocalDataSource.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(GetConfigInteractor.self) { r in
            GetConfigInteractorDefault(
                configRepository: r.resolve(ConfigRepository.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(UpdateConfigInteractor.self) { r in
            UpdateConfigInteractorDefault(
                configRepository: r.resolve(ConfigRepository.self)!
            )
        }
        .inObjectScope(.container)
    }
    
    private func configureNotifications(_ container: Container) {
        container.register(LocalNotificationLocalDataSource.self) { _ in
            LocalNotificationLocalDataSourceDefault()
        }
        .inObjectScope(.container)
        
        container.register(LocalNotificationRepository.self) { r in
            LocalNotificationRepositoryDefault(
                localDataSource: r.resolve(LocalNotificationLocalDataSource.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(NotificationsManager.self) { _ in
            NotificationsManagerDefault()
        }
        .inObjectScope(.container)
        
        container.register(UpdateRememberPasswordNotificationInteractor.self) { r in
            UpdateRememberPasswordNotificationInteractorDefault(
                notificationRepository: r.resolve(LocalNotificationRepository.self)!,
                notificationsManager: r.resolve(NotificationsManager.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(GetLocalNotificationInteractor.self) { r in
            GetLocalNotificationInteractorDefault(notificationRepository: r.resolve(LocalNotificationRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(UpdateLocalNotificationInteractor.self) { r in
            UpdateLocalNotificationInteractorDefault(notificationRepository: r.resolve(LocalNotificationRepository.self)!)
        }
        .inObjectScope(.container)
    }
    
    private func configureUser(_ container: Container) {
        container.register(UserLocalDataSource.self) { _ in
            UserLocalDataSourceDefault()
        }
        .inObjectScope(.container)
        
        container.register(RandomUserRemoteDataSource.self) { _ in
            RandomUserRemoteDataSourceDefault()
        }
        .inObjectScope(.container)
        
        container.register(UserRepository.self) { r in
            UserRepositoryDefault(
                remote: r.resolve(RandomUserRemoteDataSource.self)!,
                local: r.resolve(UserLocalDataSource.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(GetUserInteractor.self) { r in
            GetUserInteractorDefault(userRepository: r.resolve(UserRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(UpdateUserInteractor.self) { r in
            UpdateUserInteractorDefault(userRepository: r.resolve(UserRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(DeleteUserInteractor.self) { r in
            DeleteUserInteractorDefault(userRepository: r.resolve(UserRepository.self)!)
        }
        .inObjectScope(.container)
    }
    
    private func configureGeolocation(_ container: Container) {
        
        container.register(GeocoderRemoteDataSource.self) { _ in
            GeocoderRemoteDataSourceDefault()
        }
        .inObjectScope(.container)
        
        container.register(GeocoderRepository.self) { r in
            GeocoderRepositoryDefault(
                remote: r.resolve(GeocoderRemoteDataSource.self)!
            )
        }
        .inObjectScope(.container)
        
        container.register(GetUserCoordinatesInteractor.self) { r in
            GetUserCoordinatesInteractorDefault(geocoderRepository: r.resolve(GeocoderRepository.self)!)
        }
        .inObjectScope(.container)
    }
}
