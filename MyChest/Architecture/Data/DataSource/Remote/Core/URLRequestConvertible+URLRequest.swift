//
//  URLRequestConvertible+URLRequest.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation

protocol URLRequestConvertible {
    var method: HttpConstants.Method { get }
    var endpoint: URL? { get }
    
    func addHeaders(toRequest request: inout URLRequest) throws
    func addBody(toRequest request: inout URLRequest)
}

extension URLRequestConvertible {
    
    var urlRequest: URLRequest? { asURLRequest() }
    
    private func asURLRequest() -> URLRequest? {
        var request: URLRequest = URLRequest(url: endpoint!)
        request.httpMethod = method.rawValue
        do {
            try addHeaders(toRequest: &request)
            addBody(toRequest: &request)
            return request
        } catch {
            return nil
        }
    }
}
