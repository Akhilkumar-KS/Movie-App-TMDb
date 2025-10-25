//
//  View+Extensions.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI
import SwiftMessages

extension View {

    func isDeviceIpad() -> Bool {
        if (UIDevice.current.userInterfaceIdiom == .pad) {
          return true
        } else {
          return false
        }
    }

    func convertToUIView(shouldHide: Bool =  true) -> UIView {
        let convertingView = ZStack {
            Color.gray.opacity(0.000000000000001)
                .onTapGesture {
                    if shouldHide {
                        UIApplication.shared.endEditing()
                        DispatchQueue.main.async {
                            SwiftMessages.hide()
                        }
                    }
                }
            self
        }
        if let view = UIHostingController(rootView: convertingView).view {
            view.backgroundColor = .clear
            return view
        }
        return UIView()
    }

}
