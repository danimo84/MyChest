//
//  UserIdEntity.swift
//  MyChest
//
//  Created by Daniel Moraleda on 27/3/24.
//

import Foundation

struct UserIdEntity: Entity {
    
    let name: String?
    let value: String?
}

extension UserIdEntity {
    
    var id: String {
        guard let name, let value else {
            return UUID().uuidString
        }
        return "\(name)\(value)".replacingOccurrences(of: " ", with: "")
    }
}
