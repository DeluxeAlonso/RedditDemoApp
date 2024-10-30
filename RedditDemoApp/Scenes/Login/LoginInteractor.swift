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

    func getAccessToken(credential: String, code: String) async throws -> String {
        let redirectUri = AppConstants.authRedirectUri
        do {
            let response = try await authClient.getAccessToken(credential: credential, code: code, redirectUri: redirectUri)
            let accessToken = response.accessToken
            await AuthenticationManager.shared.setAccessToken(accessToken)
            return response.accessToken
        } catch {
            throw error
        }
    }

}
