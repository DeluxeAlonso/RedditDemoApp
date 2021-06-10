//
//  AccessTokenResponse.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

struct AccessTokenResponse: Decodable {

    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }

}
