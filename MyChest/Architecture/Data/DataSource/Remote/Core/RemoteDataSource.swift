//
//  RemoteDataSource.swift
//  MyChest
//
//  Created by Daniel Moraleda on 26/3/24.
//

import Foundation
import Combine

struct RemoteDataSource {
    
    private static let statusCodeOk = 200...299
    private static let statusCodeBadRequest = 400
    private static let statusCodeUnauthorized = 401
    private static let statusCodeForbidden = 403
    private static let statusCodeNotFound = 404
    private static let statusCodeServerError = 500...599
    
    static func run(_ urlRequest: URLRequest) -> AnyPublisher<Void, DataError> {
        logRequest(urlRequest)
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { _, response -> Void in
                try processResponse(response)
            }
            .mapError { $0 as? DataError ?? .unknown }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func run<D: Decodable>(_ urlRequest: URLRequest) -> AnyPublisher<D, DataError> {
        logRequest(urlRequest)
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap { data, response -> Data in
                try processResponse(response, data: data)
                return data
            }
            .decode(type: D.self, decoder: JSONDecoder())
            .mapError { 
                $0 as? DataError ?? .decoding }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

private extension RemoteDataSource {
    
    static func processResponse(_ response: URLResponse, data: Data? = nil) throws {
        if let response: HTTPURLResponse = response as? HTTPURLResponse {
            logResponse(withStatusCode: response.statusCode, forEndpoint: response.url?.absoluteString ?? "-invalid url-", headers: response.allHeaderFields.debugDescription, data: data)
            if let error = checkStatusCodeFromResponse(response) { throw error }
        }
    }
    
    static func checkStatusCodeFromResponse(_ response: HTTPURLResponse) -> DataError? {
        var error: DataError?
        switch response.statusCode {
        case statusCodeOk:
            break
        case statusCodeBadRequest:
            error = .badRequest
        case statusCodeUnauthorized:
            error = .unauthorized
        case statusCodeForbidden:
            error = .forbidden
        case statusCodeNotFound:
            error = .notFound
        case statusCodeServerError:
            error = .server
        default:
            error = .unknown
        }
        return error
    }
}

private extension RemoteDataSource {
    
    static func logRequest(_ request: URLRequest) {
        debugPrint("API_REQUEST: [\(String(describing: request.httpMethod))] \(String(describing: request.url))")
    }

    static func logResponse(withStatusCode code: Int, forEndpoint endpoint: String, headers: String, data: Data? = nil) {
        debugPrint("API_RESPONSE: [\(code)] \(endpoint)")
        debugPrint("DATA: \(String(describing: data?.debugDescription))")
    }
}
