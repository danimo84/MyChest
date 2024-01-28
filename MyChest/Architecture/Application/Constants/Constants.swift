//
//  Constants.swift
//  MyChest
//
//  Created by Daniel Moraleda on 22/1/24.
//

import Foundation

enum Constants {
    
    enum Accounts {
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
