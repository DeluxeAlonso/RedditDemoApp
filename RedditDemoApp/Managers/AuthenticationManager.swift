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

    func isUserLoggedIn() -> Bool {
        return accessToken != nil
    }

    func signOut() {
        accessToken = nil
    }

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
