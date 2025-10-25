//
//  String+Extensions.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString (self, comment: "")
    }
}
