//
//  LocalNotificationErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/3/24.
//

import Foundation

struct LocalNotificationErrorMapper {
    
    static func map(_ error: DataError) -> LocalNotificationError {
        switch error {
        default:
            return .undefined
        }
    }
}
