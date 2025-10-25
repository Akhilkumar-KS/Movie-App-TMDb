//
//  Movie= Extensions.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation

extension Movie {
    /// Build a full poster URL if you're using TheMovieDB-style paths.
    /// Adjust the base URL/size according to your API.
    var posterURL: URL? {
        guard let path = posterPath, !path.isEmpty else { return nil }
        // Example base — adapt to your image source.
        let base = "https://image.tmdb.org/t/p/w500"
        return URL(string: base + path)
    }

    /// Convert runtime minutes to "1h 23m". If runtime is nil, returns nil.
    var runtimeText: String? {
        guard let minutes = runtime, minutes > 0 else { return nil }
        let h = minutes / 60
        let m = minutes % 60
        if h > 0 {
            return "\(h)h \(m)m"
        } else {
            return "\(m)m"
        }
    }

    /// Year from releaseDate (expecting "YYYY-MM-DD"), fallback nil
    var releaseYear: String? {
        guard !releaseDate.isEmpty else { return nil }
        let components = releaseDate.split(separator: "-")
        return components.first.map(String.init)
    }
}
