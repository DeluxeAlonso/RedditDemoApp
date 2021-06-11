//
//  SceneDelegate.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)

        appCoordinator = AppCoordinator()

        window?.rootViewController = appCoordinator.getInitialViewController()
        window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url,
              let host = url.host,
              let urlSchemeHost = URLSchemeHost(rawValue: host) else {
            return
        }
        switch urlSchemeHost {
        case .authCompletion:
            AuthenticationManager.shared.handleAuthCompletionURLScheme(url)
        }
    }

}

