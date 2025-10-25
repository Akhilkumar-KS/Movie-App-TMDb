//
//  ApiRequest.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation

enum ApiRequests: RequestTypeProtocol {

    case popularMovies(page: Int)
    case movieDetails(id: Int)
    case movieCredits(id: Int)
    case moviewTrailers(id: Int)
    case searchMovies(query: String, page: Int)

    var method: RequestMethod {
        switch self {
        case .popularMovies, .movieDetails, .moviewTrailers, .movieCredits, .searchMovies:
            return .get
        }
    }

    var endPoint: String {
        switch self {
        case .popularMovies:
            return ApiConstants.Endpoints.popularMovies
        case .movieDetails(let id):
            return ApiConstants.Endpoints.movieDetails(movieId: id)
        case .movieCredits(let id):
            return ApiConstants.Endpoints.movieCredits(movieId: id)
        case .moviewTrailers(let id):
            return ApiConstants.Endpoints.movieTrailers(movieId: id)
        case .searchMovies: return ApiConstants.Endpoints.searchMovies
        }

    }

    var params: [String : Any]? {
        switch self {
        case .popularMovies(let page):
            var param = [String: Any]()
            param[ApiParameters.apiKey] = ApiConstants.apiKey
            param[ApiParameters.page] = page
            return param
        case .searchMovies(let query, let page):
            var param = [String: Any]()
            param[ApiParameters.apiKey] = ApiConstants.apiKey
            param[ApiParameters.page] = page
            param[ApiParameters.query] = query
            return param
        default:
            return [ApiParameters.apiKey: ApiConstants.apiKey]
        }
    }

}
