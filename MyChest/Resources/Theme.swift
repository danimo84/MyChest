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
        static let headline = SwiftUI.Font.system(.headline)
        static let headlineBold = SwiftUI.Font.system(.headline).bold()
        static let headlineItalic = SwiftUI.Font.system(.headline).italic()
        
        static let title = SwiftUI.Font.system(.title)
        static let titleBold = SwiftUI.Font.system(.title).bold()
        static let titleItalic = SwiftUI.Font.system(.title).italic()
        
        static let largeTitle = SwiftUI.Font.system(.largeTitle)
        static let largeTitleBold = SwiftUI.Font.system(.largeTitle).bold()
        static let largeTitleItalic = SwiftUI.Font.system(.largeTitle).italic()
        
        static let body = SwiftUI.Font.system(.body)
        static let bodyBold = SwiftUI.Font.system(.body).bold()
        static let bodyItalic = SwiftUI.Font.system(.body).italic()
        
        static let footnote = SwiftUI.Font.system(.footnote)
        static let footnoteBold = SwiftUI.Font.system(.footnote).bold()
        static let footnoteItalic = SwiftUI.Font.system(.footnote).italic()
        
        static let caption = SwiftUI.Font.system(.caption)
        static let captionBold = SwiftUI.Font.system(.caption).bold()
        static let captionItalic = SwiftUI.Font.system(.caption).italic()
    }
    
    enum Spacing {
        
        /// 4
        static let xxSmall: CGFloat = 4
        /// 8
        static let xSmall: CGFloat = 8
        /// 12
        static let small: CGFloat = 12
        /// 16
        static let medium: CGFloat = 16
        /// 24
        static let large: CGFloat = 24
        /// 32
        static let xLarge: CGFloat = 32
        /// 64
        static let xxLarge: CGFloat = 64
    }
    
    enum Radius {
        
        /// 4
        static let xSmall: CGFloat = 4
        /// 8
        static let small: CGFloat = 8
        /// 12
        static let medium: CGFloat = 12
        /// 16
        static let large: CGFloat = 16
        /// 24
        static let xLarge: CGFloat = 24
        /// 32
        static let xxLarge: CGFloat = 32
    }
    
    enum Tabbar {
        
        static let notifications: Int = 1
        static let accounts: Int = 2
        static let settings: Int = 3
    }
    
    enum Accounts {
        
        static let accountImageSize: CGFloat = 36
    }
    
    enum AccountDetail {
        
        static let accountDefaultImageSize: CGFloat = 64
        static let accountImageSize: CGFloat = 72
        static let passwordButtonsHeight: CGFloat = 30
        static let zero: Int = 0
        static var maxAccountCommentCharacters = 156
    }
    
    enum PasswordGenerator {
        
        static var letters: String = "abcdefghijklmnopqrstuvwxyz"
        static var numbers: String = "1234567890"
        static var special: String = ".,:-_{}[]*^¿?=()/&%$!"
        static var minChars: Int = 8
        static var maxChars: Int = 64
    }
}
