//
//  MovieListScreen.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI

struct MovieListScreen: View {

    @EnvironmentObject var navigator: UINavigationController
    @StateObject var viewModel = MovieListViewModel()
    @StateObject var favStore = FavStore()

    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                ZStack {
                    HStack {
                        FavoriteButton(action: {
                            navigator.navigateTo(route: .favoriteMovieListScreen(favStore: favStore))
                        })
                        Spacer()
                    }

                    Text("Home".localized)
                        .font(AppFont.bold.withSize(25))
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                }
                .frame(height: 60)
                .padding(.horizontal)
                .padding(.bottom, 20)

                CustomSearchBar(
                    text: $viewModel.searchText,
                    onSearch: {
                        viewModel.isSearching = true
                        viewModel.reset()
                        viewModel.searchMovies()
                    },
                    onReset: {
                        viewModel.isSearching = false
                        viewModel.reset()
                        viewModel.getMovies()
                    }
                )
                .padding(.vertical)


                if viewModel.movies.isEmpty {
                    Spacer()
                    Text("No Data Found".localized)
                        .foregroundColor(.gray)
                        .padding(.top, UIScreen.main.bounds.height * 0.30)
                    Spacer()
                } else {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.movies, id: \.self.id) { movie in
                            MovieCard(movie: movie, favStore: favStore)
                                .padding(.horizontal)
                                .onAppear {
                                    if viewModel.isSearching {
                                        if viewModel.searchLastId == movie.id {
                                            viewModel.searchMovies()
                                        }
                                    } else {
                                        if viewModel.lastId == movie.id {
                                            viewModel.getMovies()
                                        }
                                    }
                                }
                                .onTapGesture {
                                    navigator.navigateTo(route: .movieDetailScreen(movieId: movie.id))
                                }
                        }
                    }
                }
            }
            if viewModel.states == .screenLoading {
                LoadingView()
            }
        }
        .onChange(of: viewModel.states) { state in
            if state == .error {
                Utility.showToast("Something went wrong".localized)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    MovieListScreen()
}
