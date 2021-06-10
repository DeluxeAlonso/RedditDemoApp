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

}

extension AuthenticationManager {

    struct Constants {
        static let accessTokenKey = "RedditDemoAppAccessToken"
    }

}
