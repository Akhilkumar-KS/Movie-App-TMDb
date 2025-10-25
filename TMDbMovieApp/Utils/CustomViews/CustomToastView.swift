//
//  CustomToastView.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI


struct CustomToastView: View {

    var message: String

    var body: some View {
        HStack() {
            Text(message)
                .font(AppFont.medium.withSize(14))
                .foregroundColor(AppTheme.Toast.textColor)

        }
        .padding(isDeviceIpad() ? 20 : 10)
        .background(AppTheme.Toast.toastBackgroundColor)
        .cornerRadius(isDeviceIpad() ? 20 : 10)
        .padding(.bottom, isDeviceIpad() ? 100 : 50)
    }
}

