//
//  AlertViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 14/3/24.
//

import Foundation
import SwiftUI

final class AlertViewModel: ObservableObject {
    
    @Published var alertType: AlertType
    @Published var dismissAction: () -> Void
    @Published var confirmAction: (() -> Void)?
    
    init(
        alertType: AlertType,
        dismissAction: @escaping () -> Void,
        confirmAction: (() -> Void)? = nil
    ) {
        self.alertType = alertType
        self.dismissAction = dismissAction
        self.confirmAction = confirmAction
    }
}

extension AlertViewModel {
    
    static func empty() -> AlertViewModel {
        .init(alertType: .genericError) {
            // Intentionally empty
        }
    }
}
