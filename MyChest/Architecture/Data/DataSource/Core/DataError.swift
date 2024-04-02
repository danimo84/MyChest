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
    case decoding
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case server
    case unknown
    case invalidAddress
    case noPlacemarkForAddress
}
