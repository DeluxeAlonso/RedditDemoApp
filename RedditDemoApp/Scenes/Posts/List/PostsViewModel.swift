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
        interactor.getTopPosts { result in
            switch result {
            case .success(let posts):
                break
            case .failure(let error):
                break
            }
        }
    }

    func markAsRead(at index: Int) {

    }

    func hidePost(at index: Int) {

    }

    func hideAllPosts() {

    }

}
