//
//  ConfigErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 21/3/24.
//

import Foundation

struct ConfigErrorMapper {
    
    static func map(_ error: DataError) -> ConfigError {
        switch error {
        default:
            return .undefined
        }
    }
}
