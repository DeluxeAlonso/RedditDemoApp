//
//  PostProvider.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

enum PostProvider {

    case getTopPosts(accessToken: String, after: String?, limit: Int)

}

extension PostProvider: Endpoint {

    var base: String {
        return "https://oauth.reddit.com"
    }

    var path: String {
        switch self {
        case .getTopPosts:
            return "/top"
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getTopPosts(let accessToken, _, _):
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }

    var params: [String : Any]? {
        switch self {
        case .getTopPosts(_ , let after, let limit):
            guard let after = after else { return ["limit": limit] }
            return ["after": after, "limit": limit]
        }
    }

    var parameterEncoding: ParameterEnconding {
        switch self {
        case .getTopPosts:
            return .defaultEncoding
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTopPosts:
            return .get
        }
    }

}
