//
//  GetLinkMetadataErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 19/3/24.
//

import Foundation

struct GetLinkMetadataErrorMapper {
    
    static func map(_ error: DataError) -> GetLinkMetadataError {
        switch error {
        case .invalidUrl:
            return .invalidUrl
        default:
            return .undefined
        }
    }
}
