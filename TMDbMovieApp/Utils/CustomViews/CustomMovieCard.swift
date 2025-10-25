//
//  CustomMovieCard.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI

struct StarRatingView: View {
    let ratingOutOf10: Double
    let showNumeric: Bool

    private var starsOutOf5: Double {
        max(0, min(5, ratingOutOf10 / 2.0))
    }

    var body: some View {
        HStack(spacing: 6) {
            ZStack {
                HStack(spacing: 2) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                }
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        let starValue = Double(index) + 1.0
                        if starsOutOf5 >= starValue {
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.yellow)
                        } else if starsOutOf5 > (starValue - 1) && starsOutOf5 < starValue {
                            let fillFraction = starsOutOf5 - (starValue - 1)
                            Image(systemName: "star.fill")
                                .font(.system(size: 12))
                                .foregroundColor(.yellow)
                                .overlay(
                                    GeometryReader { geo in
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .background(.clear)
                                            .mask(
                                                Rectangle()
                                                    .size(width: geo.size.width * CGFloat(fillFraction), height: geo.size.height)
                                            )
                                    }
                                )
                        } else {
                            Image(systemName: "star")
                                .font(.system(size: 12))
                                .foregroundColor(.clear)
                        }
                    }
                }
                .allowsHitTesting(false)
            }
            if showNumeric {
                Text(String(format: "%.1f", ratingOutOf10))
                    .font(.caption)
                    .fontWeight(.semibold)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Rating \(String(format: "%.1f", ratingOutOf10)) out of 10")
    }
}


struct MovieCard: View {
    let movie: Movie
    let favStore: FavStore

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            posterView
                .frame(width: 100, height: 150)
                .cornerRadius(10)
                .shadow(radius: 4)

            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Text(movie.title)
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    FavButton(favStore: favStore, movie: movie)
                }

                HStack(spacing: 10) {
                    if let runtime = movie.runtimeText {
                        Label(runtime, systemImage: "clock")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else if let year = movie.releaseYear {
                        Text(year)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    if !movie.originalLanguage.isEmpty {
                        Text(movie.originalLanguage.uppercased())
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.leading, 2)
                    }
                }

                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)

                Spacer()

                HStack {
                    StarRatingView(ratingOutOf10: movie.voteAverage, showNumeric: true)
                    Spacer()
                    HStack(spacing: 6) {
                        Image(systemName: "person.3.fill")
                        Text("\(movie.voteCount)")
                    }
                    .font(.caption2)
                    .foregroundColor(.secondary)
                }
            }
            .padding(.vertical, 6)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(UIColor.secondarySystemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(Color(UIColor.separator), lineWidth: 0.5)
        )
        .accessibilityElement(children: .contain)
        .frame(minHeight: 220)
    }

    @ViewBuilder
    private var posterView: some View {
        if let url = movie.posterURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ZStack {
                        Rectangle().foregroundColor(Color(UIColor.systemGray5))
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .clipped()
                case .failure:
                    placeholderImage
                @unknown default:
                    placeholderImage
                }
            }
        } else {
            placeholderImage
        }
    }

    private var placeholderImage: some View {
        ZStack {
            Rectangle().foregroundColor(Color(UIColor.systemGray5))
            VStack {
                Image(systemName: "photo")
                    .font(.system(size: 28))
                    .foregroundColor(.secondary)
                Text("No Poster")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
    }
}


struct FavButton: View {
    @StateObject var favStore: FavStore
    let movie: Movie

    var body: some View {
        Button(action: {
            favStore.toggleFav(movie)
        }) {
            Image(systemName: favStore.isFav(movie.id) ? "heart.fill" : "heart")
                .font(AppFont.semibold.withSize(20))
                .foregroundColor(.red)
        }
    }
}


struct FavoriteButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                // List icon
                Image(systemName: "list.bullet")
                    .resizable()
                    .frame(width: 30, height: 20)
                    .foregroundColor(.black)

                // Heart icon overlapping
                Image(systemName: "heart.fill")
                    .resizable()
                    .frame(width: 22, height: 18)
                    .foregroundColor(.red)
                    .background(Color.white)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    FavoriteButton(action: {})
}
