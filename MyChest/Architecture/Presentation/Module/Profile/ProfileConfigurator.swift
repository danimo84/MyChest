//
//  ProfileConfigurator.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import SwiftUI

struct ProfileConfigurator {
    
    private var injector: Injector {
        MyChestInjectorProvider.shared.injector
    }
    
    init() {
        // Intentionally empty
    }
    
    func view() -> some View {
        let getUserInteractor = injector.instanceOf(GetUserInteractor.self)
        let updateUserInteractor = injector.instanceOf(UpdateUserInteractor.self)
        let deleteUserInteractor = injector.instanceOf(DeleteUserInteractor.self)
        let getUserCoordinatesInteractor = injector.instanceOf(GetUserCoordinatesInteractor.self)
        
        let presenter = ProfilePresenterDefault(
            getUserInteractor: getUserInteractor,
            updateUserInteractor: updateUserInteractor,
            deleteUserInteractor: deleteUserInteractor,
            getUserCoordinatesInteractor: getUserCoordinatesInteractor
        )
        
        let view: some View = ProfileView<ProfilePresenterDefault>(presenter: presenter)
        
        return view
    }
}
