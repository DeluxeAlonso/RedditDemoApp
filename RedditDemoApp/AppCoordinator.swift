//
//  AppCoordinator.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class AppCoordinator {

    /// Defined as an array to support multiple scenes.
    private var rootCoordinators: [Coordinator] = []

    func getInitialViewController() -> UIViewController {
        if AuthenticationManager.shared.isUserLoggedIn() {
            return builPostsSplitViewController()
        } else {
            return builLoginViewController()
        }
    }

    private func builLoginViewController() -> UIViewController {
        let loginInCoordinator = LoginCoordinator(navigationController: UINavigationController())
        loginInCoordinator.start()

        rootCoordinators.append(loginInCoordinator)

        return loginInCoordinator.navigationController
    }

    private func builPostsSplitViewController() -> UIViewController {
        let splitViewController = PostsSplitViewController.instantiate()

        // We build the master view controller
        let postsCoordinator = PostsCoordinator(navigationController: UINavigationController())
        postsCoordinator.start()

        // We build the initial detail view controller
        let emptyDetailViewController = UIViewController()

        rootCoordinators.append(postsCoordinator)

        splitViewController.viewControllers = [postsCoordinator.navigationController, emptyDetailViewController]
        return splitViewController
    }

}
