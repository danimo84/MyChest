//
//  RandomUserAPI.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

extension API.RandomUser {
    
    enum RandomUserAPI: URLRequestConvertible {
        
        case randomUser
        
        var method: HttpConstants.Method {
            switch self {
            default:
                return .get
            }
        }
        
        var endpoint: URL? {
            switch self {
            case .randomUser:
                return URL(string: HttpConstants.apiServiceBaseUrl)
            }
        }
        
        func addHeaders(toRequest request: inout URLRequest) throws {
            // Intentionally empty
        }
        
        func addBody(toRequest request: inout URLRequest) {
            // Intentionally empty
        }
    }
}
