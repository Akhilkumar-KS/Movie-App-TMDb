//
//  CustomLoaderView.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI
import LoaderUI

struct LoadingView: View {

    var color: Color = .black

    var body: some View {
        ZStack {
            Color.black.opacity(0.2).ignoresSafeArea()
            BallBeat()
                .foregroundColor(color)
                .frame(width: 40, height: 40)
        }
    }
}
