//
//  PostClientProtocol.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

protocol PostClientProtocol {

    func getTopPosts(accessToken: String,
                     after: String?,
                     completion: @escaping (Result<ListingResponse<PostResponse>, APIError>) -> Void)

}
