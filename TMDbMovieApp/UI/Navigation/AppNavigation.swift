//
//  AppNavigation.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import SwiftUI

class AppNavigation: ObservableObject {

    static var shared = AppNavigation()
    let startingRoute: AppRoute

    init(navigationController: UINavigationController = .init()) {
        self.startingRoute = .movieListScreen
    }

    func startingViewController() -> UIViewController {
        let view = startingRoute.view().navigationBarHidden(true)
        let navigationController: UINavigationController = .init()
        let viewWithCoordinator = view.environmentObject(navigationController)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        navigationController.setViewControllers([viewController], animated: false)
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }

    func present(_ route: AppRoute, animated: Bool = true, source: UINavigationController, hideNavBar: Bool = false) {
        let view = route.view()
        let destinationNavigationController: UINavigationController = .init()
        let viewWithNavigator = view.environmentObject(destinationNavigationController)
        let viewController = UIHostingController(rootView: viewWithNavigator)
        destinationNavigationController.modalPresentationStyle = .fullScreen
        destinationNavigationController.setViewControllers([viewController], animated: animated)
        if hideNavBar {
            destinationNavigationController.setNavigationBarHidden(true, animated: false)
        }
        source.present(destinationNavigationController, animated: animated)
    }

    func presentCustomModal(_ route: AppRoute, source: UINavigationController) {
        let view = route.view()
        let destinationNavigationController: UINavigationController = .init()
        let viewWithNavigator = view.environmentObject(destinationNavigationController)
        let viewController = UIHostingController(rootView: viewWithNavigator)
        viewController.view.backgroundColor = .clear
        destinationNavigationController.modalPresentationStyle = .overCurrentContext
        destinationNavigationController.setViewControllers([viewController], animated: false)
        destinationNavigationController.setNavigationBarHidden(true, animated: false)
        source.present(destinationNavigationController, animated: false)
    }

    func navigate(_ route: AppRoute, animated: Bool = true, source: UINavigationController) {
        let view = route.view().navigationBarHidden(true)
        let viewWithNavigator = view.environmentObject(source)
        let viewController = UIHostingController(rootView: viewWithNavigator)
        source.pushViewController(viewController, animated: animated)
    }

    func presentModally(_ route: AppRoute, animated: Bool = true, source: UINavigationController) {
        let view = route.view()
        let destinationNavigationController: UINavigationController = .init()
        let viewWithNavigator = view.environmentObject(destinationNavigationController)
        let viewController = UIHostingController(rootView: viewWithNavigator)
        viewController.isModalInPresentation = true
        destinationNavigationController.modalPresentationStyle = .formSheet
        destinationNavigationController.setViewControllers([viewController], animated: animated)
        source.present(destinationNavigationController, animated: animated)
    }

    func setRoot(_ route: AppRoute) {

        let keyWindow = UIApplication.shared.connectedScenes
                    .filter { $0.activationState == .foregroundActive }
                    .first(where: { $0 is UIWindowScene })
                    .flatMap({ $0 as? UIWindowScene })?.windows
                    .first(where: \.isKeyWindow)

        let view = route.view().navigationBarHidden(true)
        let destination: UINavigationController = .init()
        let viewWithNavigator = view.environmentObject(destination)
        let viewController = UIHostingController(rootView: viewWithNavigator)
        destination.setViewControllers([viewController], animated: false)
        destination.setNavigationBarHidden(true, animated: false)

        guard let window = keyWindow else { return }
        window.rootViewController = destination
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        var transitionRetryCount = 0
        let maxTransitionRetries = 10

        UIView.transition(
            with: window,
            duration: duration,
            options: options,
            animations: {},
            completion: { [weak self] finished in
                guard let self else { return }
                if finished {
                    print("Transition completed successfully.")
                    transitionRetryCount = 0 // reset on success
                } else if transitionRetryCount < maxTransitionRetries {
                    print("Transition failed. Retrying... (\(transitionRetryCount + 1))")
                    transitionRetryCount += 1
                    setRoot(route)
                } else {
                    print("Transition failed after maximum retries. Please reopen the app.")
                }
            }
        )
    }
}

