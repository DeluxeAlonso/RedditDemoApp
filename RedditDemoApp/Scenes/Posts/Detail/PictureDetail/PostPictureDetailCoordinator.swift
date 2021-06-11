//
//  PostPictureDetailCoordinator.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import UIKit

final class PostPictureDetailCoordinator: PostPictureDetailCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    var pictureURL: URL?
    var presentingViewController: UIViewController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = PostPictureDetailViewController.instantiate()

        viewController.viewModel = PostPictureDetailViewModel(pictureURL: pictureURL)
        viewController.coordinator = self

        navigationController.pushViewController(viewController, animated: false)

        presentingViewController.present(navigationController, animated: true, completion: nil)
    }

    func dismiss(completion: (() -> Void)?) {
        let presentedViewController = navigationController.topViewController
        presentedViewController?.dismiss(animated: true) { [weak self] in
            completion?()
            self?.parentCoordinator?.childDidFinish()
        }
    }

}
