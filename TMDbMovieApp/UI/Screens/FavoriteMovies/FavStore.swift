//
//  FavStore.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation
import SwiftUI


class FavStore: ObservableObject {

    init() {
        fetchFavs()
    }

    func fetchFavs() {
        favs.removeAll()
        let favMovies = Storage.shared.get(key: .favoriteMovies, type: [Movie].self) ?? []
        favs = favMovies
    }

    @Published var favs = [Movie]()

    func isFav(_ id: Int) -> Bool {
        return favs.contains { $0.id == id }
    }

    func toggleFav(_ movie: Movie) {
        if isFav(movie.id) {
            removeFav(movie)
        } else {
            addFav(movie)
        }
    }

    private func addFav(_ movie: Movie) {
        favs.append(movie)
        Storage.shared.set(value: favs, key: .favoriteMovies)
    }

    private func removeFav(_ movie: Movie) {
        if let index = favs.firstIndex(of: movie) {
            favs.remove(at: index)
        }
        Storage.shared.set(value: favs, key: .favoriteMovies)
    }

}

