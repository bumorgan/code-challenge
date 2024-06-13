//
//  APIError.swift
//  code-challenge
//
//  Created by Bruno de Mello Morgan on 13/06/24.
//

import Foundation

enum APIError: Error {
    case request(message: String)
    case network(message: String)
    case status(message: String)
    case parsing(message: String)
    case other(message: String)

    static func map(_ error: Error) -> APIError {
        return (error as? APIError) ?? .other(message: error.localizedDescription)
    }
}
