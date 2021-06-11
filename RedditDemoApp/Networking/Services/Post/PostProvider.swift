//
//  PostProvider.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

enum PostProvider {

    case getTopPosts(accessToken: String, after: String?)

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
        case .getTopPosts(let accessToken, _):
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }

    var params: [String : Any]? {
        switch self {
        case .getTopPosts(_ , let after):
            guard let after = after else { return nil }
            return ["after": after]
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
