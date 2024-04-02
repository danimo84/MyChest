//
//  UserCoordinatesErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 30/3/24.
//

import Foundation

struct UserCoordinatesErrorMapper {
    
    static func map(_ error: DataError) -> UserCoordinatesError {
        switch error {
        case .invalidAddress:
            return .invalidAddress
        default:
            return .undefined
        }
    }
}
