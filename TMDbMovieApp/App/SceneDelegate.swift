//
//  SceneDelegate.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UIStoryboard(name: "Launch Screen", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        window?.backgroundColor = .black
        window?.overrideUserInterfaceStyle = .light
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.window?.rootViewController = AppNavigation.shared.startingViewController()
            if let window = self.window {
                // A mask of options indicating how you want to perform the animations.
                let options: UIView.AnimationOptions = .transitionCrossDissolve

                // The duration of the transition animation, measured in seconds.
                let duration: TimeInterval = 0.3

                // Creates a transition animation.
                // Though `animations` is optional,
                UIView.transition(with: window,
                                  duration: duration,
                                  options: options, animations: {},
                                  completion: { _ in
                    // maybe do something on completion here
                })
            }
        }
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
