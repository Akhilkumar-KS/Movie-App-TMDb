//
//  CustomSearchBar.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    var onReset: () -> Void

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search...", text: $text)
                .focused($isFocused)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .tint(.red)
                .onSubmit {
                    withAnimation {
                        onSearch()
                    }
                }

            if !text.isEmpty {
                Button {
                    text = ""
                    onReset()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(AppFont.semibold.withSize(20))
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
            }

            Button("Search") {
                withAnimation {
                    onSearch()
                    isFocused = false
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

