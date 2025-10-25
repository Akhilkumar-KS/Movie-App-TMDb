//
//  FavListScreen.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI

struct FavListScreen: View {

    @EnvironmentObject var navigator: UINavigationController
    @StateObject var favStore: FavStore

    var body: some View {
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

                Text("Favourites".localized)
                    .font(AppFont.bold.withSize(25))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
            }
            .frame(height: 60)

            Spacer()

            if favStore.favs.isEmpty {
                Text("No favourites yet!".localized)
                    .padding(.top, UIScreen.main.bounds.height * 0.35)
            } else {
                ForEach(favStore.favs, id: \.id) { movie in
                    MovieCard(movie: movie, favStore: favStore)
                        .onTapGesture {
                            navigator.navigateTo(route: .movieDetailScreen(movieId: movie.id))
                        }
                }
            }
        }
        .padding()
    }
}

//#Preview {
//    FavListScreen()
//}
