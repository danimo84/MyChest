//
//  LPMetadataProvider+Extension.swift
//  MyChest
//
//  Created by Daniel Moraleda on 25/2/24.
//

import Foundation
import LinkPresentation
import Combine

extension LPMetadataProvider {
    
    func fetchMetadata(for url: URL) -> AnyPublisher<LinkMetadata?, Error> {
        
        Future<LinkMetadata?, Error> { completion in
            self.startFetchingMetadata(for: url) { meta, error in
                if let meta {
                    let imageMetadata = meta.value(forKey: "imageMetadata") as? AnyObject
                    let url = imageMetadata?.value(forKey: "URL") as? URL
                    
                    completion(.success(
                        .init(
                            title: meta.title ?? "",
                            description: meta.value(forKey: "summary") as? String ?? "",
                            url: meta.url?.absoluteString ?? "",
                            imageUrl: url?.absoluteString ?? ""
                        )
                    ))

                } else if let error {
                    completion(.failure(error))
                }
            }
        }
        .handleEvents(receiveCancel: {
            self.cancel()
        })
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
