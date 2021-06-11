//
//  PostsViewState.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

enum PostsViewState: Equatable {

    case initial
    case empty
    case paging([Post], next: Int)
    case populated([Post])
    case error(ErrorDescriptable)

    static func == (lhs: PostsViewState, rhs: PostsViewState) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial):
            return true
        case (let .paging(lhsEntities, _), let .paging(rhsEntities, _)):
            return lhsEntities == rhsEntities
        case (let .populated(lhsEntities), let .populated(rhsEntities)):
            return lhsEntities == rhsEntities
        case (.empty, .empty):
            return true
        case (.error, .error):
            return true
        default:
            return false
        }
    }

    var currentPage: Int {
        switch self {
        case .initial, .populated, .empty, .error:
            return 1
        case .paging(_, let page):
            return page
        }
    }

    var currentJobs: [Post] {
        switch self {
        case .populated(let posts):
            return posts
        case .paging(let posts, _):
            return posts
        case .empty, .error, .initial:
            return []
        }
    }

    var needsPrefetch: Bool {
        switch self {
        case .initial, .populated, .empty, .error:
            return false
        case .paging:
            return true
        }
    }

}
