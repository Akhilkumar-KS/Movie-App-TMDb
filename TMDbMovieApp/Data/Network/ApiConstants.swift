//
//  ApiConstants.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation

struct ApiConstants {
    static let baseUrl = Environment.baseURL

    static let apiKey = Environment.apiKey

    struct Endpoints {
        static let popularMovies = "movie/popular"

        static func movieDetails(movieId: Int) -> String {
            return "movie/\(movieId)"
        }
        static func movieCredits(movieId: Int) -> String {
            return "movie/\(movieId)/credits"
        }
        static func movieTrailers(movieId: Int) -> String {
            return "movie/\(movieId)/videos"
        }
        static let searchMovies = "search/movie"
    }

    struct Header {
        static let contentType = "Content-Type"
        static let authorization = "Authorization"
        static let contentTypeValue = "application/json"
    }
}

struct ApiServiceConstant {
    static let timeoutInterval: TimeInterval = 10
    static let retryLimit = 0
    static let retryDelayInterval: TimeInterval = 2
    static let noInternetConnection = "NO_INTERNET_CONNECTION"
    static let invalidResponse = "INVALID_RESPONSE"
}
