//
//  PostsSplitViewController.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class PostsSplitViewController: UISplitViewController, Storyboarded, UISplitViewControllerDelegate {

    static var storyboardName: String = "Posts"

    private var globalNavigationManager = GlobalNavigationManager()

    deinit {
        NotificationCenter.default.removeObserver(self, name: CustomNotification.didSignOut.name, object: nil)
    }

    // MARK: - Initializers

    init(preferredDisplayMode: UISplitViewController.DisplayMode) {
        super.init(nibName: nil, bundle: nil)
        self.preferredDisplayMode = preferredDisplayMode
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupObservers()
    }

    // MARK: - Private

    private func setupObservers() {
        NotificationCenter.default.addObserver(forName: CustomNotification.didSignOut.name,
                                               object: nil, queue: .current) { [weak self] _ in
            guard let self = self else { return }
            self.globalNavigationManager.showLoginScreen(from: self)
        }
    }

    // MARK: - UISplitViewControllerDelegate

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }

}
