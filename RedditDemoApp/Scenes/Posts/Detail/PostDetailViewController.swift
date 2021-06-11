//
//  PostDetailViewController.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

class PostDetailViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var titleLabel: UILabel!

    static var storyboardName: String = "Posts"

    var viewModel: PostDetailViewModelProtocol?
    weak var coordinator: PostDetailCoordinatorProtocol?

    deinit {
        print("PostDetailViewController")
    }

    // MARK: - Initializers

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    // MARK: - Private

    private func setupUI() {
        titleLabel.textColor = .label
        titleLabel.font = FontHelper.semiBold(withSize: 36)
    }
    
    private func setupBindings() {
        title = viewModel?.author
        titleLabel.text = viewModel?.title
    }

}
