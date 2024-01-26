//
//  TabBarViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 18/1/24.
//

import Foundation

protocol TabBarViewModel: ObservableObject {
    
    var selectedTabItem: Int { get set }
}

final class TabBarViewModelDefault {
    
    @Published var selectedTabItem: Int = 1
}

extension TabBarViewModelDefault: TabBarViewModel {
    
}
