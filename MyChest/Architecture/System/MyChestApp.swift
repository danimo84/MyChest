//
//  MyChestApp.swift
//  MyChest
//
//  Created by Daniel Moraleda on 16/1/24.
//

import SwiftUI
import SwiftData

@main
struct MyChestApp: App {
    
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Account.self,
//            PasswordGeneratorConfig.self
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
    var body: some Scene {
        WindowGroup {
            TabBarConfigurator().view()
        }
        //.modelContainer(sharedModelContainer)
    }
}
