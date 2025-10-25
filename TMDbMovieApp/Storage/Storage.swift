//
//  Storage.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation

class Storage {

    enum DefaultsKey: String {
        case favoriteMovies
    }

    static let shared = Storage()
    private let defaults = UserDefaults.standard

    private init() {}

    func set<T: Codable>(value: T?, key: DefaultsKey) {
        guard let value = value else {
            defaults.removeObject(forKey: key.rawValue)
            return
        }
        let data = try? JSONEncoder().encode(value)
        defaults.set(data, forKey: key.rawValue)
    }

    func get<T: Codable>(key: DefaultsKey, type: T.Type) -> T? {
        guard let data = defaults.data(forKey: key.rawValue) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }


    func reset(key: DefaultsKey) {
        defaults.removeObject(forKey: key.rawValue)
    }

}
