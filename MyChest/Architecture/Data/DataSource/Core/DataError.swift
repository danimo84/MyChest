//
//  DataError.swift
//  MyChest
//
//  Created by Daniel Moraleda on 30/1/24.
//

import Foundation

enum DataError: Error, Equatable {
    
    case invalidUrl
    case encoding
    case unknown
}
