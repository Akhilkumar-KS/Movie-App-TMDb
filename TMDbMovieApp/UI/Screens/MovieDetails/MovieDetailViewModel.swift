//
//  MovieDetailViewModel.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation


class MovieDetailViewModel: ObservableObject {

    @Published var state: MovieDetailStates = .empty

    func fetchMovieDetail(movieId: Int) {
        state = .loading
        Task {
            do {
                let request1 = ApiRequests.movieDetails(id: movieId)
                let response1 = try await ApiService.shared.requestAsync(type: request1) as? [String: Any]  ?? [String: Any]()
                let responseData1 = try Utility.fromDictToObj(type: MovieDetail.self, from: response1)
                let request2 = ApiRequests.movieCredits(id: movieId)
                let response2 = try await ApiService.shared.requestAsync(type: request2) as? [String: Any]  ?? [String: Any]()
                let responseData2 = try Utility.fromDictToObj(type: MovieCredits.self, from: response2)
                let request3 = ApiRequests.moviewTrailers(id: movieId)
                let response3 = try await ApiService.shared.requestAsync(type: request3) as? [String: Any]  ?? [String: Any]()
                let responseData3 = try Utility.fromDictToObj(type: MovieTrailer.self, from: response3)
                await MainActor.run {
                    self.state = .apiSuccess(movieDetails: responseData1, cast: responseData2.cast, trailers: responseData3.results)
                }
            } catch {
                await MainActor.run {
                    self.state = .error
                }
            }
        }
    }
}


enum MovieDetailStates: Equatable {
    static func == (lhs: MovieDetailStates, rhs: MovieDetailStates) -> Bool {
        switch (lhs, rhs) {
        case (.apiSuccess(let lhsData, _, _), .apiSuccess(let rhsData, _, _)):
            return lhsData.id == rhsData.id
        case (.empty, .empty), (.loading, .loading), (.error, .error):
            return true
        default:
            return false
        }
    }
    
    case empty
    case loading
    case apiSuccess(movieDetails: MovieDetail, cast: [Cast], trailers: [Video])
    case error
}
