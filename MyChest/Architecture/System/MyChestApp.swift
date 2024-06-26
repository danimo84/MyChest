//
//  MyChestApp.swift
//  MyChest
//
//  Created by Daniel Moraleda on 16/1/24.
//

import SwiftUI

@main
struct MyChestApp: App {
    
    @UIApplicationDelegateAdaptor var delegate: AppDelegate
    @ObservedObject var router = Router.shared
    
    var body: some Scene {
        WindowGroup {
            TabBarConfigurator().view()
                .environmentObject(router)
        }
    }
}
