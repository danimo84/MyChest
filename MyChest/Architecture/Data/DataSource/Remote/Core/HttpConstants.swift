//
//  HttpConstants.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

enum HttpConstants {
    
    static private var baseUrl: String = "https://randomuser.me/"
    static var apiServiceBaseUrl: String {
        baseUrl + "api/"
    }
}

extension HttpConstants {
    
    enum Method: String {
        
        case get = "GET"
        case post = "POST"
        case patch = "PATCH"
        case put = "PUT"
        case delete = "DELETE"
    }

    enum Header {
        
        static let contentType = "Content-Type"
        static let accept = "Accept"
        static let language = "Accept-Language"
        static let auth = "Authorization"
        static let deviceId = "Device-Id"
    }
    
    enum HeaderValue {
        
        static let applicationJson = "application/json"
        static let all = "*/*"
    }
}
