//
//  DeleteAccountErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 5/4/24.
//

import Foundation

struct DeleteAccountErrorMapper {
    
    static func map(_ error: DataError) -> DeleteAccountError {
        switch error {
        default:
            return .undefined
        }
    }
}
