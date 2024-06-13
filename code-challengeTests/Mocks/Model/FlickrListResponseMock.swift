//
//  FlickrListResponseMock.swift
//  code-challengeTests
//
//  Created by Bruno de Mello Morgan on 13/06/24.
//

@testable import code_challenge

extension FlickrListResponse {
    static var mock: FlickrListResponse {
        .init(items: [])
    }
}

extension FlickrItem {
    static var mock: FlickrItem {
        .init(title: "Title", media: ["m": ""], author: "Author", description: "Description")
    }
}
