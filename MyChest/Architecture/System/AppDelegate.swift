//
//  AppDelegate.swift
//  PokemonSwiftUI
//
//  Created by Daniel Moraleda on 20/10/23.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var orientationLock = UIInterfaceOrientationMask.portrait
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureDependencyInjection()
        swiftDataStorage()
        initNotificationsManger()
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Intentionally empty
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        Self.orientationLock
    }
}
