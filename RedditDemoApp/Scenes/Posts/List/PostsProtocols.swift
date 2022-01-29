//
//  PostsProtocols.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

protocol PostsViewModelProtocol {

    var viewState: Bindable<PostsViewState> { get }
    var didUpdatePost: Bindable<Int?> { get }
    var didRemovePost: Bindable<Int?> { get }

    var needsPrefetch: Bool { get }

    /**
    * Retrieves the top posts. If shouldRefresh is true, the posts are reset.
    * - Parameters:
    *      - shouldRefresh: indicates if posts should be reset.
    */
    func getTopPosts(shouldRefresh: Bool)

    /**
     * Marks post at a specific index as read.
     * - Parameters:
     *      - index: the post index.
     */
    func markAsRead(at index: Int)

    /**
     Hides post at a specific index.
     */
    func hidePost(at index:Int)

    /**
     Hides all posts.
     */
    func hideAllPosts()

    func numberOfPosts() -> Int
    func post(at index: Int) -> Post
    func buildPostCellModel(at index: Int) -> PostCellViewModelProtocol

}

protocol PostsInteractorProtocol {

    func getTopPosts(after: String?, completion: @escaping (Result<[Post], Error>) -> Void)
    func getTopPosts(after: String?) async throws -> [Post]

    func markPostAsRead(id: String, completion: @escaping (Result<Void, Error>) -> Void)

}

protocol PostsCoordinatorProtocol: Coordinator {

    func showPostDetail(_ post: Post)

    /**
     * Shows the post picture in a new screen.
     * - Parameters:
     *      - pictureURL: the picture url to be rendered in the new screen.
     */
    func showPictureDetail(for pictureURL: URL?)

}
