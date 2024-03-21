//
//  DefaultImageViewModel.swift
//  MyChest
//
//  Created by Daniel Moraleda on 20/3/24.
//

import Foundation

struct DefaultImageViewModel {
    
    var width: CGFloat
    var height: CGFloat
    var image: String?
    
    init(
        width: CGFloat,
        height: CGFloat,
        image: String? = nil
    ) {
        self.width = width
        self.height = height
        self.image = image
    }
}
