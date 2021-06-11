//
//  PostCell.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import UIKit

protocol PostCellDelegate: AnyObject {

    func postCell(_ postCell: PostCell, didTapDismissButton tapped: Bool)

}

class PostCell: UITableViewCell {

    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!

    var viewModel: PostCellViewModelProtocol? {
        didSet {
            setupBindings()
        }
    }

    weak var delegate: PostCellDelegate?

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Private

    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.title
        dateLabel.text = viewModel.relativeDate
        commentsLabel.text = viewModel.commentCount
    }

    // MARK: - Actions

    @IBAction private func dismissButtonTapped(_ sender: Any) {
        
    }

}
