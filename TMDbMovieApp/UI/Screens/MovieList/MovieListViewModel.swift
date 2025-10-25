//
//  MovieListViewModel.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation


class MovieListViewModel : ObservableObject {

    @Published var states: MovieListScreenStates = .emptyState
    @Published var movies: [Movie] = []
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false

    var page: Int = 1
    var totalPages: Int = 1
    var lastId: Int = 000000

    var searchPage: Int = 1
    var searchTotalPages: Int = 1
    var searchLastId: Int = 000000

    init() {
        getMovies()
    }

    func getMovies() {
        guard page <= totalPages else { return }
        states = movies.count > 0 ? .listLoading : .screenLoading
        let request = ApiRequests.popularMovies(page: page)
        Task {
            do {
                let response = try await ApiService.shared.requestAsync(type: request) as? [String: Any]  ?? [String: Any]()
                let responseData = try Utility.fromDictToObj(type: MovieListResponse.self, from: response)
                await MainActor.run {
                    for movie in responseData.results {
                        if !movies.contains(where: { $0.id == movie.id }){
                            self.movies.append(movie)
                        }
                    }
                    lastId = responseData.results.last?.id ?? 00000
                    totalPages = responseData.totalPages
                    page += 1
                    self.states = .apiSuccess
                }
            } catch {
                await MainActor.run {
                    self.states = .error
                }
            }
        }
    }

    func searchMovies() {
        if searchPage == 1 && movies.count > 0 {
            reset()
        }
        guard searchPage <= searchTotalPages else { return }
        states = movies.count > 0 ? .listLoading : .screenLoading
        let request = ApiRequests.searchMovies(query: searchText, page: searchPage)
        Task {
            do {
                let response = try await ApiService.shared.requestAsync(type: request) as? [String: Any]  ?? [String: Any]()
                let responseData = try Utility.fromDictToObj(type: MovieListResponse.self, from: response)
                await MainActor.run {
                    for movie in responseData.results {
                        if !movies.contains(where: { $0.id == movie.id }){
                            self.movies.append(movie)
                        }
                    }
                    searchLastId = responseData.results.last?.id ?? 00000
                    searchTotalPages = responseData.totalPages
                    searchPage += 1
                    self.states = .apiSuccess
                }
            } catch {
                await MainActor.run {
                    self.states = .error
                }
            }
        }
    }

    func reset() {
        page = 1
        totalPages = 1
        lastId = 00000
        movies.removeAll()
        searchPage = 1
        searchTotalPages = 1
        searchLastId = 00000
    }

}

enum MovieListScreenStates: Equatable {
    case emptyState
    case screenLoading
    case listLoading
    case apiSuccess
    case error
}
