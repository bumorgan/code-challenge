//
//  FlickrListResponse.swift
//  code-challenge
//
//  Created by Bruno de Mello Morgan on 13/06/24.
//

import Foundation

struct FlickrListResponse: Decodable {
    let items: [FlickrItem]
}

struct FlickrItem: Decodable, Hashable {
    let title: String
    let media: [String: String]
    let author: String
    let description: String
    let published: String
}

extension FlickrItem {
    var publishedDate: String {
        let fixedFormatter = DateFormatter()
        fixedFormatter.locale = Locale(identifier: "en_US_POSIX")
        fixedFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        fixedFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let date = fixedFormatter.date(from: published) else { return "" }
        return date.formatted()
    }
}
