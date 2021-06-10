//
//  AuthPermissionCoordinator.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

final class AuthPermissionCoordinator: AuthPermissionCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var authPermissionURL: URL?
    var presentingViewController: UIViewController!
    var authPermissionDelegate: AuthPermissionViewControllerDelegate?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = AuthPermissionViewController.instantiate()

        viewController.viewModel = AuthPermissionViewModel(authPermissionURL: authPermissionURL)
        viewController.delegate = authPermissionDelegate
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: false)

        presentingViewController.present(navigationController, animated: true, completion: nil)
    }

    func dismiss(completion: (() -> Void)? = nil) {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            completion?()
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
