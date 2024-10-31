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

    func getTopPosts(after: String?) async throws -> [Post] {
        guard let accessToken = await AuthenticationManager.shared.accessToken else {
            throw APIError.requestFailed
        }

        let visitedPosts = visitedPostStore.findAll()
        let visitedIds = visitedPosts.map { $0.id }

        do {
            let response = try await postClient.getTopPosts(accessToken: accessToken, after: after, limit: 50)
            return buildPosts(from: response, and: visitedIds)
        } catch {
            if case APIError.notAuthenticated = error { await AuthenticationManager.shared.signOut() }
            throw error
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
