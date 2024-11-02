//
//  PostClient.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

final class PostClient: APIClient, PostClientProtocol {

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

    // MARK: - PostClientProtocol

    func getTopPosts(accessToken: String, after: String?, limit: Int) async throws -> ListingResponse<PostResponse> {
        let request = PostProvider.getTopPosts(accessToken: accessToken, after: after, limit: limit).request
        return try await fetch(with: request, decodingType: ListingResponse<PostResponse>.self)
    }

}
