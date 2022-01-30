//
//  PostsTests.swift
//  RedditDemoAppTests
//
//  Created by Alonso on 11/06/21.
//

import XCTest
@testable import RedditDemoApp

class PostsTests: XCTestCase {

    private var mockInteractor: MockPostsInteractor!
    private var viewModelToTest: PostsViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockInteractor = MockPostsInteractor()
        viewModelToTest = PostsViewModel(interactor: mockInteractor)
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        viewModelToTest = nil
        try super.tearDownWithError()
    }

    func testPostFullname() {
        //Arrange
        let post = Post.with(id: "test", kind: "t3")
        //Act
        let fullname = post.fullName
        //Assert
        XCTAssertEqual(fullname, "t3_test")
    }

    func testGetPostsEmpty() {
        //Arrange
        let expectation = XCTestExpectation(description: "View state should be set to empty")
        //Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(self.viewModelToTest.viewState.value, .empty)
            expectation.fulfill()
        }
        mockInteractor.getTopPostsResult = Result.success([])
        viewModelToTest.getTopPosts(shouldRefresh: false)
        //Assert
        wait(for: [expectation], timeout: 5)
    }

    func testGetPostsError() {
        //Arrange
        let expectation = XCTestExpectation(description: "View state should be set to bad request error")
        //Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .error(APIError.badRequest))
            expectation.fulfill()
        }
        mockInteractor.getTopPostsResult = Result.failure(APIError.badRequest)
        viewModelToTest.getTopPosts(shouldRefresh: false)
        //Assert
        wait(for: [expectation], timeout: 5)
    }

    func testGetPostsPaging() {
        //Arrange
        let postsToEvaluate = [Post.with(id: "1"), Post.with(id: "2")]
        let expectation = XCTestExpectation(description: "View state should be set to paging")
        //Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, .paging(postsToEvaluate, after: postsToEvaluate.last?.fullName))
            expectation.fulfill()
        }
        mockInteractor.getTopPostsResult = Result.success(postsToEvaluate)
        viewModelToTest.getTopPosts(shouldRefresh: false)
        //Assert
        wait(for: [expectation], timeout: 5)
    }

    func testGetPostsPopulated() {
        //Arrange
        let postsToEvaluate = [Post.with(id: "1"), Post.with(id: "2")]

        var statesToReceive: [PostsViewState] = [
            .paging(postsToEvaluate, after: postsToEvaluate.last?.fullName),
            .populated(postsToEvaluate)
        ]
        let expectation = XCTestExpectation(description: "View state should be set to populated state after a paging state")
        //Act
        viewModelToTest.viewState.bind { state in
            XCTAssertEqual(state, statesToReceive.removeFirst())
            expectation.fulfill()
        }
        mockInteractor.getTopPostsResult = Result.success(postsToEvaluate)
        viewModelToTest.getTopPosts(shouldRefresh: false)
        // Seconds fetch should return empty values to simulate no more pages
        _ = Task.delayed(byTimeInterval: 0.5) {
            self.mockInteractor.getTopPostsResult = Result.success([])
            self.viewModelToTest.getTopPosts(shouldRefresh: false)
        }
        //Assert
        wait(for: [expectation], timeout: 5)
    }

}

extension Task where Failure == Error {
    static func delayed(byTimeInterval delayInterval: TimeInterval,
                        priority: TaskPriority? = nil,
                        operation: @escaping @Sendable () async throws -> Success) -> Task {
        Task(priority: priority) {
            let delay = UInt64(delayInterval * 1_000_000_000)
            try await Task<Never, Never>.sleep(nanoseconds: delay)
            return try await operation()
        }
    }
}
