//
//  GetLocalNotificationErrorMapper.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/3/24.
//

import Foundation

struct GetLocalNotificationErrorMapper {
    
    static func map(_ error: DataError) -> GetLocalNotificationError {
        switch error {
        default:
            return .undefined
        }
    }
}
