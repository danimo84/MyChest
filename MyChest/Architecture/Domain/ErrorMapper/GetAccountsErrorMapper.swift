//
//  GetAccountsErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

struct GetAccountsErrorMapper {
    
    static func map(_ error: DataError) -> GetAccountsError {
        switch error {
        default:
            return .undefined
        }
    }
}
