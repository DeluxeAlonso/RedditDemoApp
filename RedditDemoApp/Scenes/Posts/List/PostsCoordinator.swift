//
//  PostsCoordinator.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

final class PostsCoordinator: NSObject, PostsCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let interactor = PostsInteractor(postClient: PostClient())
        let viewModel = PostsViewModel(interactor: interactor)

        let viewController = PostsViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.coordinator = self

        navigationController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func showPostDetail(_ post: Post) {

    }

}

// MARK: - UINavigationControllerDelegate

extension PostsCoordinator: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        // Check whether our view controller array already contains that view controller.
        // If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        unwrappedParentCoordinator.childDidFinish()
    }

}
