//
//  UINavigationController+Extension.swift
//  TMDbMovieApp
//
//  Created by akhilkumar on 25/10/25.
//

import Foundation

import UIKit

extension UINavigationController: @retroactive ObservableObject {
    
    func navigateTo(route: AppRoute) {
        AppNavigation.shared.navigate(route, source: self)
    }
    
    func presentScreen(route: AppRoute) {
        AppNavigation.shared.present(route, source: self)
    }
    
    func presentModally(route: AppRoute) {
        AppNavigation.shared.presentModally(route, source: self)
    }
    
    func presentCustomModal(route: AppRoute) {
        AppNavigation.shared.presentCustomModal(route, source: self)
    }
    
    func setRoot(route: AppRoute) {
        AppNavigation.shared.setRoot(route)
    }
    
    func pop() {
        popViewController(animated: true)
    }
    
    func pop(viewsToPop: Int) {
        if viewControllers.count > viewsToPop {
            let controller = viewControllers[viewControllers.count - viewsToPop - 1]
            popToViewController(controller, animated: true)
        }
    }
    
    func popToRoot() {
        popToRootViewController(animated: true)
    }
}


extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
