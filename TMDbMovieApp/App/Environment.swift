//
//  Environment.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation

public enum Environment {

    enum PlistKeys {
        static let rootURL = "ROOT_URL"
        static let apiKey = "API_KEY"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    static let baseURL: String = {
        guard let rootURLString = Environment.infoDictionary[PlistKeys.rootURL] as? String else {
            fatalError("Root URL not set in plist")
        }
        return rootURLString
    }()

    static let apiKey: String = {
        guard let apiKeyString = Environment.infoDictionary[PlistKeys.apiKey] as? String else {
            fatalError("Api Key not set in plist")
        }
        return apiKeyString
    }()

}

