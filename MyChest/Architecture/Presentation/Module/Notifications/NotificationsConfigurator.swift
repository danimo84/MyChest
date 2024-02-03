//
//  NotificationsConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 2/2/24.
//

import SwiftUI

struct NotificationsConfigurator {
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    func view() -> some View {
        
        let notificationRepository = injector.instanceOf(LocalNotificationRepository.self)
        
        let viewModel = NotificationsViewModelDefault(notificationRepository: notificationRepository)
        
        let view: some View = NotificationsView<NotificationsViewModelDefault>(viewModel: viewModel)
        
        return view
    }
}
