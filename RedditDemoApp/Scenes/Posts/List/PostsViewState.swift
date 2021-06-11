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
    case paging([Post], after: String?)
    case populated([Post])
    case error(Error)

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

    var currentAfter: String? {
        switch self {
        case .initial, .populated, .empty, .error:
            return nil
        case .paging(_, let after):
            return after
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
