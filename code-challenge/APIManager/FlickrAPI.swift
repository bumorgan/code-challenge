//
//  FlickrAPI.swift
//  code-challenge
//
//  Created by Bruno de Mello Morgan on 13/06/24.
//

import Foundation
import Combine

protocol FlickrFetchable {
    func fetchFlickrList(tags: String) -> AnyPublisher<FlickrListResponse, APIError>
}

class FlickrAPI {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension FlickrAPI {
    struct CharactersAPIComponent {
        static let scheme = "https"
        static let host = "api.flickr.com"
        static let path = "/services/feeds/photos_public.gne"
    }
    
    func urlComponentForFlickrList(tags: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = CharactersAPIComponent.scheme
        components.host = CharactersAPIComponent.host
        components.path = CharactersAPIComponent.path
        components.queryItems = [
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1")
        ]
        if !tags.isEmpty {
            components.queryItems?.append(URLQueryItem(name: "tags", value: tags))
        }
        
        return components
    }
}


extension FlickrAPI: FlickrFetchable, Fetchable {
    func fetchFlickrList(tags: String) -> AnyPublisher<FlickrListResponse, APIError> {
        return fetch(with: self.urlComponentForFlickrList(tags: tags), session: self.session)
    }
}
