//
//  PostsInteractor.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

final class PostsInteractor: PostsInteractorProtocol {

    private let postClient: PostClientProtocol

    init(postClient: PostClientProtocol) {
        self.postClient = postClient
    }

    func getTopPosts(after: String?, completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let accessToken = AuthenticationManager.shared.accessToken else {
            completion(.failure(APIError.requestFailed))
            return
        }
        postClient.getTopPosts(accessToken: accessToken, after: after) { result in
            switch result {
            case .success(let response):
                let posts = self.buildPosts(from: response)
                completion(.success(posts))
            case .failure(let error):
                switch error {
                case .notAuthenticated:
                    AuthenticationManager.shared.signOut()
                default:
                    break
                }
                completion(.failure(error))
            }
        }
    }

    private func buildPosts(from response: ListingResponse<PostResponse>) -> [Post] {
        let listingData = response.data.children
        let posts = listingData.map { dataResponse -> Post in
            let kind = dataResponse.kind
            let postResponse = dataResponse.data
            let post = Post(id: postResponse.id,
                            title: postResponse.title,
                            kind: kind,
                            author: postResponse.author,
                            thumbnail: postResponse.thumbnail,
                            timestamp: postResponse.timestamp,
                            numberOfComments: postResponse.numberOfComments,
                            picture: postResponse.url)
            return post
        }
        return posts
    }

}
