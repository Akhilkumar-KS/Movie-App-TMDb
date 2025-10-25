//
//  Utility.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//


import SwiftUI
import SwiftMessages


class Utility {

    private init() {}

    static func showToast(_ message: String) {
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.presentationContext = .window(windowLevel: .statusBar)
        config.duration = .seconds(seconds: 2)
        config.dimMode = .color(color: .clear, interactive: true)
        config.interactiveHide = false
        DispatchQueue.main.async {
            SwiftMessages.show(config: config, view: CustomToastView(message: message).convertToUIView())
        }
    }

    static func fromDictToObj<T>(type: T.Type, from: [String: Any]) throws -> T where T: Decodable {
            let jsonData = try JSONSerialization.data(withJSONObject: from)
            let responseData = try JSONDecoder().decode(type, from: jsonData )
            return responseData
    }

}
