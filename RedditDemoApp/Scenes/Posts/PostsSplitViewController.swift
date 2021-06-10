//
//  PostsSplitViewController.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class PostsSplitViewController: UISplitViewController, Storyboarded, UISplitViewControllerDelegate {

    static var storyboardName: String = "Posts"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    // MARK: - UISplitViewControllerDelegate

    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        return true
    }

}
