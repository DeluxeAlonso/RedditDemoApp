//
//  LoginCoordinator.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

final class LoginCoordinator: LoginCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    // MARK: - Initializers

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let interactor = LoginInteractor(authClient: AuthClient())

        let viewController = LoginViewController.instantiate()

        viewController.viewModel = LoginViewModel(interactor: interactor)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: true)
    }

    func showAuthPermission(for authPermissionURL: URL?,
                            and authPermissionDelegate: AuthPermissionViewControllerDelegate) {
        let navigationController = UINavigationController()
        let coordinator = AuthPermissionCoordinator(navigationController: navigationController)

        coordinator.authPermissionURL = authPermissionURL
        coordinator.authPermissionDelegate = authPermissionDelegate
        coordinator.presentingViewController = self.navigationController.topViewController
        coordinator.parentCoordinator = unwrappedParentCoordinator

        unwrappedParentCoordinator.childCoordinators.append(coordinator)
        coordinator.start()
    }

    func showMainScreen(from window: UIWindow?) {
        guard let window = window else { return }
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [UIView.AnimationOptions.curveEaseOut,
                                    UIView.AnimationOptions.transitionCrossDissolve],
                          animations: {},
                          completion: { _ in
                            let splitViewController = PostsSplitViewController.instantiate()
                            window.rootViewController = splitViewController
                          })
    }

}

