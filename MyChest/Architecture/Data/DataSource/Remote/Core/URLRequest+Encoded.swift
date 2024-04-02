//
//  URLRequest+Encoded.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

extension URLRequest {
    
    mutating func addEncodedBody(withParams params: Encodable) {
        httpBody = try? JSONEncoder().encode(params)
    }
}
