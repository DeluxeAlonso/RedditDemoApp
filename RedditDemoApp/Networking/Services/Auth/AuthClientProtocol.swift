//
//  AuthClientProtocol.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

protocol AuthClientProtocol {

    func getAccessToken(credential: String,
                        code: String,
                        redirectUri: String,
                        completion: @escaping (Result<AccessTokenResponse, APIError>) -> Void)

}
