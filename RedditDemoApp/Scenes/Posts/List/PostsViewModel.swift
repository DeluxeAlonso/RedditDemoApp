//
//  PostsViewModel.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

final class PostsViewModel: PostsViewModelProtocol {

    private let interactor: PostsInteractorProtocol

    private(set) var viewState: Bindable<PostsViewState> = Bindable(.initial)

    private var posts: [Post] = []

    // MARK: - Initializers

    init(interactor: PostsInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - PostsViewModelProtocol

    func getTopPosts() {

    }

    func markAsRead(at index: Int) {

    }

    func hidePost(at index: Int) {

    }

    func hideAllPosts() {

    }

}
