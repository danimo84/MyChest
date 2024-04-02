//
//  UserError.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

enum UserError: Error, Equatable {
    
    case undefined
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case server
    case decoding
}
