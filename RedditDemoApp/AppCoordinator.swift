//
//  AppCoordinator.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class AppCoordinator {

    private var currentRootCoordinator: Coordinator?

    func getInitialViewController() -> UIViewController {
        if AuthenticationManager.shared.isUserLoggedIn() {
            return builPostsSplitViewController()
        } else {
            return builLoginViewController()
        }
    }

    func builLoginViewController() -> UIViewController {
        let loginInCoordinator = LoginCoordinator(navigationController: UINavigationController())
        loginInCoordinator.start()

        currentRootCoordinator = loginInCoordinator

        return loginInCoordinator.navigationController
    }

    func builPostsSplitViewController() -> UIViewController {
        let splitViewController = PostsSplitViewController(preferredDisplayMode: .oneBesideSecondary)

        // We build the master view controller
        let postsCoordinator = PostsCoordinator(navigationController: UINavigationController())
        postsCoordinator.start()

        // We build the initial detail view controller
        let emptyDetailViewController = UIViewController()

        currentRootCoordinator = postsCoordinator

        splitViewController.viewControllers = [postsCoordinator.navigationController, emptyDetailViewController]
        return splitViewController
    }

}
