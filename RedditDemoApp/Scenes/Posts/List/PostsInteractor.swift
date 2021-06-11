//
//  PostsInteractor.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

final class PostsInteractor: PostsInteractorProtocol {

    private let postClient: PostClientProtocol
    private let visitedPostStore: PersistenceStore<VisitedPost>

    init(postClient: PostClientProtocol, visitedPostStore: PersistenceStore<VisitedPost>) {
        self.postClient = postClient
        self.visitedPostStore = visitedPostStore
    }

    func getTopPosts(after: String?, completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let accessToken = AuthenticationManager.shared.accessToken else {
            completion(.failure(APIError.requestFailed))
            return
        }

        let visitedPosts = visitedPostStore.findAll()
        let visitedIds = visitedPosts.map { $0.id }

        postClient.getTopPosts(accessToken: accessToken, after: after, limit: 50) { result in
            switch result {
            case .success(let response):
                let posts = self.buildPosts(from: response, and: visitedIds)
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

    func markPostAsRead(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        visitedPostStore.saveVisitedPost(id: id)
        completion(.success(Void()))
    }

    private func buildPosts(from response: ListingResponse<PostResponse>, and visitedIds: [String]) -> [Post] {
        let listingData = response.data.children
        let posts = listingData.map { dataResponse -> Post in
            let kind = dataResponse.kind
            let postResponse = dataResponse.data
            let read = visitedIds.contains(postResponse.id)
            let post = Post(id: postResponse.id,
                            title: postResponse.title,
                            kind: kind,
                            author: postResponse.author,
                            thumbnail: postResponse.thumbnail,
                            timestamp: postResponse.timestamp,
                            numberOfComments: postResponse.numberOfComments,
                            picture: postResponse.url,
                            read: read)
            return post
        }
        return posts
    }

}
