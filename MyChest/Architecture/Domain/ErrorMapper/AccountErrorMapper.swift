//
//  AccountErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct AccountErrorMapper {
    
    static func map(_ error: DataError) -> AccountError {
        switch error {
        default:
            return .undefined
        }
    }
}
