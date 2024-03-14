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
        
        static let small_4: CGFloat = 4
        static let small_8: CGFloat = 8
        static let medium_12: CGFloat = 12
        static let medium_16: CGFloat = 16
        static let medium_24: CGFloat = 24
        static let large_32: CGFloat = 32
        static let large_64: CGFloat = 64
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
        
        static let accountImageSize: CGFloat = 36
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
