//
//  Router.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI

public protocol Router {

    associatedtype ViewType: View

    @ViewBuilder
    func view() -> ViewType
}
