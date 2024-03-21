//
//  LinkMetadataErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/3/24.
//

import Foundation

struct LinkMetadataErrorMapper {
    
    static func map(_ error: DataError) -> LinkMetadataError {
        switch error {
        case .invalidUrl:
            return .invalidUrl
        default:
            return .undefined
        }
    }
}
