//
//  AuthClient.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

class AuthClient: APIClient, AuthClientProtocol {

    let session: URLSession

    // MARK: - Initializers

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    convenience init() {
        let configuration: URLSessionConfiguration = .default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData

        self.init(configuration: configuration)
    }

    // MARK: - AuthClientProtocol

    func getAccessToken(credential: String,
                        code: String,
                        redirectUri: String,
                        completion: @escaping (Result<AccessTokenResponse, APIError>) -> Void) {
        let request = AuthProvider.getAccessToken(encodedCredential: credential, code: code, redirectUri: redirectUri).request
        fetch(with: request, decode: { json -> AccessTokenResponse? in
            guard let requestToken = json as? AccessTokenResponse else { return nil }
            return requestToken
        }, completion: completion)
    }

}
