//
//  PostDetailViewModel.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

final class PostDetailViewModel: PostDetailViewModelProtocol {

    let title: String
    let author: String

    init(post: Post) {
        self.title = post.title
        self.author = "u/\(post.author)"
    }

}
