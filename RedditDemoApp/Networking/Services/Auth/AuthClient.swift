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

    func getAccessToken(credential: String, code: String, redirectUri: String) async throws -> AccessTokenResponse {
        let request = AuthProvider.getAccessToken(encodedCredential: credential, code: code, redirectUri: redirectUri).request
        return try await fetch(with: request, decodingType: AccessTokenResponse.self)
    }

}
