//
//  PostCell.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import UIKit

protocol PostCellDelegate: AnyObject {

    func postCell(_ postCell: PostCell, didTapDismissButton tapped: Bool)

    func postCell(_ postCell: PostCell, didTapDownloadButton image: UIImage)

    func postCell(_ postCell: PostCell, didTapThumbnail url: URL)

}

class PostCell: UITableViewCell {

    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var readMarkImageView: UIImageView!
    @IBOutlet private weak var thumbnailImageView: UIImageView!

    var viewModel: PostCellViewModelProtocol? {
        didSet {
            setupBindings()
        }
    }

    private var initialThumbnailWidthConstant: CGFloat!

    weak var delegate: PostCellDelegate?

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    // MARK: - Private

    private func setupUI() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(thumbnailTapGestureAction))
        thumbnailImageView.addGestureRecognizer(gesture)

        authorLabel.font = FontHelper.light(withSize: 17)
        descriptionLabel.font = FontHelper.light(withSize: 17)
        dateLabel.font = FontHelper.light(withSize: 17)
        commentsLabel.font = FontHelper.light(withSize: 17)
    }

    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.title
        dateLabel.text = viewModel.relativeDate
        commentsLabel.text = viewModel.commentCount

        readMarkImageView.isHidden = viewModel.wasRead

        if let thumbnailURL = viewModel.thumbnailURL {
            thumbnailImageView.isHidden = false
            thumbnailImageView.setImage(from: thumbnailURL, with: UIImage(named: "RedditLogo"))
        } else {
            thumbnailImageView.image = UIImage(named: "RedditLogo")
            thumbnailImageView.isHidden = true
        }
    }

    // MARK: - Selectors

    @objc private func thumbnailTapGestureAction() {
        guard let url = viewModel?.pictureURL else { return }
        delegate?.postCell(self, didTapThumbnail: url)
    }

    // MARK: - Actions

    @IBAction private func dismissButtonTapped(_ sender: Any) {
        delegate?.postCell(self, didTapDismissButton: true)
    }

    @IBAction private func downloadThumbnailButtonTapped(_ sender: UIButton) {
        guard let image = thumbnailImageView.image else { return }
        delegate?.postCell(self, didTapDownloadButton: image)
    }

}
