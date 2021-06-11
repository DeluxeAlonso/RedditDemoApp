//
//  PostsProtocols.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

protocol PostsViewModelProtocol {

    var viewState: Bindable<PostsViewState> { get }
    var didRemovePost: Bindable<Int?> { get }

    var needsPrefetch: Bool { get }

    /**
     Retrieves the top posts. If shouldRefresh is true, the posts are reset.
     */
    func getTopPosts(shouldRefresh: Bool)

    func markAsRead(at index: Int)

    func hidePost(at index:Int)
    func hideAllPosts()

    func numberOfPosts() -> Int
    func buildPostCellModel(at index: Int) -> PostCellViewModelProtocol

}

protocol PostsInteractorProtocol {

    func getTopPosts(after: String?, completion: @escaping (Result<[Post], Error>) -> Void)

}

protocol PostsCoordinatorProtocol: Coordinator {

    func showPostDetail(_ post: Post)

}
