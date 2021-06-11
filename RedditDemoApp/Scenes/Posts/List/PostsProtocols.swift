//
//  PostsProtocols.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

protocol PostsViewModelProtocol {

    var viewState: Bindable<PostsViewState> { get }

    /**
     Retrieves the top posts.
     */
    func getTopPosts()

    func markAsRead(at index: Int)

    func hidePost(at index:Int)
    func hideAllPosts()

}

protocol PostsInteractorProtocol {

    func getTopPosts(completion: @escaping (Result<[Post], Error>) -> Void)

}

protocol PostsCoordinatorProtocol: Coordinator {

    func showPostDetail(_ post: Post)

}
