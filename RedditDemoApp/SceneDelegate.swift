//
//  SceneDelegate.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: Coordinator!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)

        mainCoordinator = AppCoordinator(navigationController: UINavigationController())
        mainCoordinator.start()

        window?.rootViewController = mainCoordinator.navigationController
        window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url,
              let queryComponents = url.queryParameters,
              let code = queryComponents["code"] else {
            return
        }
        // TODO - Move this logic to authentication manager
        NotificationCenter.default.post(name: CustomNotification.authCodeReceived.name,
                                        object: nil, userInfo: ["code": code])
    }

}

