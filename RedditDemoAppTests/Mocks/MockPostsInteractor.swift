//
//  MockPostsInteractor.swift
//  RedditDemoAppTests
//
//  Created by Alonso on 11/06/21.
//

import Foundation
@testable import RedditDemoApp

class MockPostsInteractor: PostsInteractorProtocol {

    private(set) var markPostAsReadCallCount = 0
    func markPostAsRead(id: String) async throws {
        markPostAsReadCallCount += 1
    }

    var getTopPostsResult: Result<[Post], Error>!
    func getTopPosts(after: String?) async throws -> [Post] {
        return try getTopPostsResult.get()
    }

}
