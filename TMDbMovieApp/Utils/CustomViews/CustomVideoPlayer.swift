//
//  CustomVideoPlayer.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {
    let videoKey: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.backgroundColor = .black
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoKey)?playsinline=1") else { return }
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

// MARK: - Carousel Video View
struct VideoCarouselView: View {
    let videos: [Video]
    @State private var selectedIndex = 0

    var body: some View {
        TabView(selection: $selectedIndex) {
            ForEach(videos.indices, id: \.self) { index in
                VStack {
                    YouTubePlayerView(videoKey: videos[index].key)
                        .frame(maxWidth: .infinity)
                        .frame(height: 250)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                        .padding(.horizontal)

                    Text(videos[index].name)
                        .font(.headline)
                        .padding(.top, 8)
                        .padding(.horizontal)
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct ContentView: View {
    let sampleVideos: [Video] = [
        Video(iso639_1: "en", iso3166_1: "US", name: "Trailer 1", key: "dQw4w9WgXcQ", site: "YouTube", size: 1080, type: "Trailer", official: true, publishedAt: "2023-10-25", videoId: "1"),
        Video(iso639_1: "en", iso3166_1: "US", name: "Trailer 2", key: "eY52Zsg-KVI", site: "YouTube", size: 1080, type: "Trailer", official: true, publishedAt: "2023-10-25", videoId: "2")
    ]

    var body: some View {
        VideoCarouselView(videos: sampleVideos)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
