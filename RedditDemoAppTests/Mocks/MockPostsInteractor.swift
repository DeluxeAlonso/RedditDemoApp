//
//  MockPostsInteractor.swift
//  RedditDemoAppTests
//
//  Created by Alonso on 11/06/21.
//

import Foundation
@testable import RedditDemoApp

class MockPostsInteractor: PostsInteractorProtocol {

    var getTopPostsResult: Result<[Post], Error>!
    func getTopPosts(after: String?, completion: @escaping (Result<[Post], Error>) -> Void) {
        completion(getTopPostsResult)
    }

    var markPostAsReadResult: Result<Void, Error>!
    func markPostAsRead(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(markPostAsReadResult)
    }

}
