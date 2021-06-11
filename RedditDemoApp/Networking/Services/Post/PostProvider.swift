//
//  PostProvider.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

enum PostProvider {

    case getTopPosts(accessToken: String)

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
        case .getTopPosts(let accessToken):
            return ["Authorization": "Bearer \(accessToken)"]
        }
    }

    var params: [String : Any]? {
        switch self {
        case .getTopPosts:
            return nil
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
