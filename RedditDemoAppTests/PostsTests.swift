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
        mockInteractor.getTopPostsResult = Result.success([])
        //Act
        viewModelToTest.getTopPosts(shouldRefresh: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .empty)
    }

    func testGetPostsError() {
        //Arrange
        mockInteractor.getTopPostsResult = Result.failure(APIError.badRequest)
        //Act
        viewModelToTest.getTopPosts(shouldRefresh: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .error(APIError.badRequest))
    }

    func testGetPostsPaging() {
        //Arrange
        let postsToEvaluate = [Post.with(id: "1"), Post.with(id: "2")]
        mockInteractor.getTopPostsResult = Result.success(postsToEvaluate)
        //Act
        viewModelToTest.getTopPosts(shouldRefresh: false)
        let next = postsToEvaluate.last?.fullName
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .paging(postsToEvaluate, after: next))
    }

    func testGetPostsPopulated() {
        //Arrange
        let postsToEvaluate = [Post.with(id: "1"), Post.with(id: "2")]
        mockInteractor.getTopPostsResult = Result.success(postsToEvaluate)
        //Act
        viewModelToTest.getTopPosts(shouldRefresh: false)
        // Seconds fetch should return empty values
        mockInteractor.getTopPostsResult = Result.success([])
        viewModelToTest.getTopPosts(shouldRefresh: false)
        //Assert
        XCTAssertEqual(viewModelToTest.viewState.value, .populated(postsToEvaluate))
    }

}
