//
//  Data+Extensions.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation

extension Data {
    func prettyPrintFormat() -> String {
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
            let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
            let prettyString = String(data: prettyData, encoding: .utf8.self)
        else {
            return "{}"
        }
        return prettyString
    }
}
