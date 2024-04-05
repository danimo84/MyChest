//
//  GetUserErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct GetUserErrorMapper {
    
    static func map(_ error: DataError) -> GetUserError {
        switch error {
        case .badRequest:
            return .badRequest
        case .unauthorized:
            return .unauthorized
        case .forbidden:
            return .forbidden
        case .notFound:
            return .notFound
        case .server:
            return .server
        case .decoding:
            return .decoding
        default:
            return .undefined
        }
    }
}
