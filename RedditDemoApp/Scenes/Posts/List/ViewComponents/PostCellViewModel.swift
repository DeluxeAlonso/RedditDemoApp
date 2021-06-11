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
    var pictureURL: URL? { get }
    var relativeDate: String { get }
    var wasRead: Bool { get }

}

final class PostCellViewModel: PostCellViewModelProtocol {

    let title: String
    let author: String
    let commentCount: String
    let relativeDate: String
    let wasRead: Bool

    private(set) var thumbnailURL: URL?
    private(set) var pictureURL: URL?

    init(post: Post) {
        self.title = post.title
        self.author = post.author
        self.wasRead = post.read
        self.commentCount = "\(post.numberOfComments) comments"
        if let thumbnail = post.thumbnail {
            self.thumbnailURL = URL(string: thumbnail)
        }
        if let picture = post.picture {
            self.pictureURL = URL(string: picture)
        }
        let date = Date(timeIntervalSince1970: post.timestamp)
        relativeDate = date.timeAgoDisplay()
    }

}
