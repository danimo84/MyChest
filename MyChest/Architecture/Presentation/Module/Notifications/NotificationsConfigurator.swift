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
        
        let getLocalNotificationInteractor = injector.instanceOf(GetLocalNotificationInteractor.self)
        let updateLocalNotificationInteractor = injector.instanceOf(UpdateLocalNotificationInteractor.self)
        
        let viewModel = NotificationsPresenterDefault(
            getLocalNotificationInteractor: getLocalNotificationInteractor,
            updateLocalNotificationInteractor: updateLocalNotificationInteractor
        )
        
        let view: some View = NotificationsView<NotificationsPresenterDefault>(viewModel: viewModel)
        
        return view
    }
}
