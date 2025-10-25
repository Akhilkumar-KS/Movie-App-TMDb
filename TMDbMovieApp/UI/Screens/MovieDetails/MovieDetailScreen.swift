//
//  MovieDetailScreen.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI

struct MovieDetailScreen: View {

    @EnvironmentObject var navigator: UINavigationController
    @StateObject var viewModel = MovieDetailViewModel()

    let movieId: Int

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                ZStack {
                    HStack {
                        Button(action: { navigator.pop() }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(Color.black)
                                Text("Back".localized)
                                    .font(AppFont.regular.withSize(20))
                                    .foregroundColor(Color.black)
                            }
                        }
                        Spacer()
                    }
                    
                    Text("Movie Details".localized)
                        .font(AppFont.bold.withSize(25))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 60)
                
                Spacer()
                switch viewModel.state {
                case .loading:
                    Color.clear
                case .error, .empty:
                    Text("No Data Available".localized)
                        .padding(.top, UIScreen.main.bounds.height * 0.35)
                case .apiSuccess(let movieDetials, let cast, let trailers):
                    MovieDetailView(
                        movie: movieDetials,
                        cast: cast,
                        trailers: trailers
                    )
                }
            }
            .padding()
            if viewModel.state == .loading {
                LoadingView()
            }
        }
        .onChange(of: viewModel.state) { state in
            if state == .error {
                Utility.showToast("Something went wrong".localized)
            }
        }
        .onAppear {
            viewModel.fetchMovieDetail(movieId: movieId)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    MovieDetailScreen(movieId: 1010756)
}


import SwiftUI

struct MovieDetailView: View {
    let movie: MovieDetail
    let cast: [Cast]
    let trailers: [Video]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // MARK: - Poster
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: UIScreen.main.bounds.width * 0.9)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.black.opacity(0.6), .clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(maxHeight: UIScreen.main.bounds.width * 0.9)
            }

            VStack(alignment: .leading, spacing: 8) {
                // MARK: - Title
                Text(movie.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // MARK: - Rating & Runtime
                HStack(spacing: 20) {
                    Label("\(String(format: "%.1f", movie.voteAverage)) / 10", systemImage: "star.fill")
                        .foregroundColor(.yellow)

                    if movie.runtime > 0 {
                        Label("\(movie.runtime) min", systemImage: "clock.fill")
                            .foregroundColor(.gray)
                    }
                }

                // MARK: - Genres
                if !movie.genres.isEmpty {
                    Text("Genres: \(movie.genres.map { $0.name }.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Divider()

                // MARK: - Plot
                Text("Plot")
                    .font(.headline)
                Text(movie.overview)
                    .font(.body)
                    .foregroundColor(.secondary)

                Divider()

                if !cast.isEmpty {
                    Text("Cast")
                        .font(.headline)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(cast, id: \.self.id) { member in
                                VStack {
                                    AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(member.profilePath ?? "")")) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 80, height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } placeholder: {
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(width: 80, height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    }

                                    Text(member.name)
                                        .font(.caption)
                                        .lineLimit(1)
                                }
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }

                VideoCarouselView(videos: trailers)
                    .frame(height: 400)
            }
            .padding(.horizontal)
        }
    }
}
