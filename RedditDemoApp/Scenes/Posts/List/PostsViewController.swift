//
//  PostsViewController.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class PostsViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var tableView: UITableView!
    
    static var storyboardName: String = "Posts"

    var viewModel: PostsViewModelProtocol?
    weak var coordinator: PostsCoordinatorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
