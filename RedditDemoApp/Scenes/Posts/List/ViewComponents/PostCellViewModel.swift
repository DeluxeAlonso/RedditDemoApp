//
//  PostCellViewModel.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import Foundation

protocol PostCellViewModelProtocol {

    var title: String { get }
    var author: String { get }
    var commentCount: String { get }
    var thumbnailURL: URL? { get }
    var relativeDate: String { get }

}

final class PostCellViewModel: PostCellViewModelProtocol {

    let title: String
    let author: String
    let commentCount: String
    let thumbnailURL: URL?
    let dateText: String

    init(post: Post) {
        self.title = post.title
        self.author = post.author
        self.commentCount = "\(post.numberOfComments) comments"
        if let thumbnail = post.thumbnail {
            self.thumbnailURL = URL(string: thumbnail)
        }
        relativeDate = "5 hours ago"
    }

}
