//
//  GetConfigErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/3/24.
//

import Foundation

struct GetConfigErrorMapper {
    
    static func map(_ error: DataError) -> GetConfigError {
        switch error {
        default:
            return .undefined
        }
    }
}
