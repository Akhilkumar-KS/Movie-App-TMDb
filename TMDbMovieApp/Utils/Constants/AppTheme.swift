//
//  AppTheme.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI

struct AppTheme {
    static let primaryBackgroundColor = Color(hex: 0xFFF9F9F9)
    static let primaryTextColor = Color(hex: 0xFF1E1E1E)
    static let blackColor = Color(hex: 0xFF000000)
    static let whiteColor = Color(hex: 0xFFFFFFFF)
    static let primaryLightTextColor = Color(hex: 0xFF949494)

    struct Toast {
        static let toastBackgroundColor = Color(hex: 0xFF212121)
        static let textColor = Color(hex: 0xFFFFFEFB)
    }

}

enum AppFont {
    case regular
    case medium
    case bold
    case semibold
    
    func withSize(_ size: CGFloat) -> Font {
        var weight: Font.Weight = .regular
        switch self {
        case .regular: weight = .regular
        case .medium: weight = .medium
        case .bold: weight = .bold
        case .semibold: weight = .semibold
        }
        return Font.system(size: size, weight: weight)
    }
}
