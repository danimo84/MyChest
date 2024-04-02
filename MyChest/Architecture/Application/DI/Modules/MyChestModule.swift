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
        configureAccounts(container)
        configureSettings(container)
        configureNotifications(container)
        configureUser(container)
        configureGeolocation(container)
    }
    
    private func configureAccounts(_ container: Container) {
        container.register(AccountLocalDataSource.self) { _ in
            AccountLocalDataSourceDefault()
        }
        .inObjectScope(.container)
        
        container.register(LinkMetadataRemoteDataSource.self) { _ in
            LinkMetadataRemoteDataSourceDefault()
        }
        
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
        
        container.register(PasswordGeneratorManager.self) { _ in
            PasswordGeneratorManagerDefault()
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
    }
}
