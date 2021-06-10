//
//  LoginInteractors.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

final class LoginInteractor: LoginInteractorProtocol {

    private let authClient: AuthClientProtocol

    // MARK: - Initializers

    init(authClient: AuthClientProtocol) {
        self.authClient = authClient
    }

    // MARK: - LoginInteractorProtocol

    func getAccessToken(credential: String,
                        code: String,
                        completion: @escaping (Result<String, Error>) -> Void) {
        let redirectUri = AppConstants.authRedirectUri
        authClient.getAccessToken(credential: credential, code: code, redirectUri: redirectUri) { result in
            switch result {
            case .success(let response):
                // Save token
                completion(.success(response.accessToken))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
