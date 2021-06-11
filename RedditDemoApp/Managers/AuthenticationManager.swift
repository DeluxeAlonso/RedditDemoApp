//
//  AuthenticationManager.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

class AuthenticationManager {

    static let shared = AuthenticationManager()

    @KeychainStorage(key: Constants.accessTokenKey)
    var accessToken: String?

    /**
     * Checks if the user is logged in into the app.
     * - Returns: true if the user is logged in, false if not.
     */
    func isUserLoggedIn() -> Bool {
        return accessToken != nil
    }

    /**
     * Signs out the user.
     */
    func signOut() {
        accessToken = nil
        NotificationCenter.default.post(name: CustomNotification.didSignOut.name, object: nil, userInfo: nil)
    }

    /**
     * Handles the  authentication response url scheme.
     * - Parameters:
     *      - url: the url of the processed url scheme.
     */
    func handleAuthCompletionURLScheme(_ url: URL) {
        guard let queryComponents = url.queryParameters,
              let code = queryComponents["code"] else {
            return
        }
        NotificationCenter.default.post(name: CustomNotification.authCodeReceived.name,
                                        object: nil, userInfo: ["code": code])
    }

}

extension AuthenticationManager {

    struct Constants {
        static let accessTokenKey = "RedditDemoAppAccessToken"
    }

}
