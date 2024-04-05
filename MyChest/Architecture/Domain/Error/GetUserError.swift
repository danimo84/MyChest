//
//  GetUserError.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

enum GetUserError: Error, Equatable {
    
    case undefined
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case server
    case decoding
}
