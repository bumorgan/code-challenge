//
//  FlickrAPIMock.swift
//  code-challengeTests
//
//  Created by Bruno de Mello Morgan on 13/06/24.
//

import Combine
@testable import code_challenge

class FlickrAPIMock: FlickrFetchable {
    var expectedResult: Result<FlickrListResponse, APIError>!
    
    func fetchFlickrList(tags: String) -> AnyPublisher<FlickrListResponse, APIError> {
        expectedResult.publisher.eraseToAnyPublisher()
    }
}
