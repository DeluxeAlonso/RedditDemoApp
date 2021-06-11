//
//  PostDetailCoordinator.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

final class PostDetailCoordinator: Coordinator, PostDetailCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = PostDetailViewController.instantiate()
        viewController.viewModel = PostDetailViewModel()
        viewController.coordinator = self

        let detailNavigationController = UINavigationController()
        detailNavigationController.pushViewController(viewController, animated: false)

        navigationController.showDetailViewController(detailNavigationController, sender: nil)
    }

}
