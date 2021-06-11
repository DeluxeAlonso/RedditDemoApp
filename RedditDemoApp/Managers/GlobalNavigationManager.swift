//
//  GlobalNavigationManager.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class GlobalNavigationManager {

    func showLoginScreen(from viewController: UIViewController) {
        guard let window = viewController.view.window else { return }
        guard let sceneDelegate = window.windowScene?.delegate as? SceneDelegate,
              let appCoordinator = sceneDelegate.appCoordinator else {
            return
        }

        UIView.transition(with: window,
                          duration: 0.5,
                          options: [UIView.AnimationOptions.curveEaseOut,
                                    UIView.AnimationOptions.transitionCrossDissolve],
                          animations: {},
                          completion: { _ in
                            window.rootViewController = appCoordinator.builLoginViewController()
                          })
    }

    func showMainScreen(from viewController: UIViewController) {
        guard let window = viewController.view.window else { return }
        guard let sceneDelegate = window.windowScene?.delegate as? SceneDelegate,
              let appCoordinator = sceneDelegate.appCoordinator else {
            return
        }
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [UIView.AnimationOptions.curveEaseOut,
                                    UIView.AnimationOptions.transitionCrossDissolve],
                          animations: {},
                          completion: { _ in
                            window.rootViewController = appCoordinator.builPostsSplitViewController()
                          })
    }

}
