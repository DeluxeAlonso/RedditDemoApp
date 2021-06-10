//
//  AuthProvider.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

enum AuthProvider {

    case getAccessToken(encodedCredential: String, code: String, redirectUri: String)

}

extension AuthProvider: Endpoint {

    var base: String {
        return "https://www.reddit.com"
    }

    var path: String {
        switch self {
        case .getAccessToken:
            return "/api/v1/access_token"
        }
    }

    var headers: [String : String]? {
        switch self {
        case .getAccessToken(let encodedCredential, _, _):
            return ["Authorization": "Basic \(encodedCredential)"]
        }
    }

    var params: [String : Any]? {
        switch self {
        case .getAccessToken(_, let code, let redirectUri):
            return ["code": code, "redirect_uri": redirectUri, "grant_type": "authorization_code"]
        }
    }

    var parameterEncoding: ParameterEnconding {
        switch self {
        case .getAccessToken:
            return .defaultEncoding
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getAccessToken:
            return .post
        }
    }

}
