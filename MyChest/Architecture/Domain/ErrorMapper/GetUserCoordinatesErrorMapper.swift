//
//  GetUserCoordinatesErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 30/3/24.
//

import Foundation

struct GetUserCoordinatesErrorMapper {
    
    static func map(_ error: DataError) -> GetUserCoordinatesError {
        switch error {
        case .invalidAddress:
            return .invalidAddress
        default:
            return .undefined
        }
    }
}
