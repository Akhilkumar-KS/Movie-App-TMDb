//
//  RequestProtocol.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case patch = "PATCH"
    case put = "PUT"
    case head = "HEAD"
    case options = "OPTIONS"
}

public protocol RequestTypeProtocol {
    var method: RequestMethod { get }
    var endPoint: String { get }
    var params: [String: Any]? { get }
    var url: String { get }
}

extension RequestTypeProtocol {
    var url: String {
        let componets = [ApiConstants.baseUrl,
                         self.endPoint]
        return componets.joined(separator: "")
    }
}
