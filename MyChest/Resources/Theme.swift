//
//  Theme.swift
//  MyChest
//
//  Created by Daniel Moraleda on 22/2/24.
//

import Foundation
import SwiftUI

enum Theme {
    
    enum Font {
        static var headline = SwiftUI.Font.system(.headline)
        static var headlineBold = SwiftUI.Font.system(.headline).bold()
        static var headlineItalic = SwiftUI.Font.system(.headline).italic()
        
        static var title = SwiftUI.Font.system(.title)
        static var titleBold = SwiftUI.Font.system(.title).bold()
        static var titleItalic = SwiftUI.Font.system(.title).italic()
        
        static var largeTitle = SwiftUI.Font.system(.largeTitle)
        static var largeTitleBold = SwiftUI.Font.system(.largeTitle).bold()
        static var largeTitleItalic = SwiftUI.Font.system(.largeTitle).italic()
        
        static var body = SwiftUI.Font.system(.body)
        static var bodyBold = SwiftUI.Font.system(.body).bold()
        static var bodyItalic = SwiftUI.Font.system(.body).italic()
        
        static var footnote = SwiftUI.Font.system(.footnote)
        static var footnoteBold = SwiftUI.Font.system(.footnote).bold()
        static var footnoteItalic = SwiftUI.Font.system(.footnote).italic()
        
        static var caption = SwiftUI.Font.system(.caption)
        static var captionBold = SwiftUI.Font.system(.caption).bold()
        static var captionItalic = SwiftUI.Font.system(.caption).italic()
    }
}
