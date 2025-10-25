//
//  AppRoutes.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI

enum AppRoute: Router {

    case movieListScreen
    case movieDetailScreen(movieId: Int)
    case favoriteMovieListScreen(favStore: FavStore)

    @ViewBuilder
    func view() -> some View {
        switch self {
        case .movieListScreen: MovieListScreen()
        case .movieDetailScreen(movieId: let movieId): MovieDetailScreen(movieId: movieId)
        case .favoriteMovieListScreen(let FavStore): FavListScreen(favStore: FavStore)
        }
    }
}
