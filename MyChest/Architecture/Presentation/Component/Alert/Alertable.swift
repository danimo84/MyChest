//
//  Alertable.swift
//  MyChest
//
//  Created by Daniel Moraleda on 14/3/24.
//

import Foundation

protocol Alertable: ObservableObject {
    
    var alertIsVisible: Bool { get set }
    var alertViewModel: AlertViewModel { get set }
}
