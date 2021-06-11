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
    private(set) var didRemovePost: Bindable<Int?> = Bindable(nil)

    private var posts: [Post] = []

    var needsPrefetch: Bool {
        return viewState.value.needsPrefetch
    }

    // MARK: - Initializers

    init(interactor: PostsInteractorProtocol) {
        self.interactor = interactor
    }

    // MARK: - PostsViewModelProtocol

    func getTopPosts(shouldRefresh: Bool) {
        let currentAfter = shouldRefresh ? nil : viewState.value.currentAfter
        fetchTopPosts(after: currentAfter)
    }

    func markAsRead(at index: Int) {

    }

    func hidePost(at index: Int) {
        posts.remove(at: index)
        if posts.isEmpty {
            self.viewState.value = .empty
        } else {
            didRemovePost.value = index
        }
    }

    func hideAllPosts() {
        self.posts = []
        self.viewState.value = .empty
    }

    func numberOfPosts() -> Int {
        return posts.count
    }

    func buildPostCellModel(at index: Int) -> PostCellViewModelProtocol {
        let post = posts[index]
        return PostCellViewModel(post: post)
    }

    func post(at index: Int) -> Post {
        return posts[index]
    }

    // MARK: - Private

    private func updatePosts(_ posts: [Post], state: PostsViewState) {
        self.posts = posts
        viewState.value = state
    }

    private func fetchTopPosts(after: String?) {
        interactor.getTopPosts(after: after) { result in
            switch result {
            case .success(let posts):
                let postsResult = self.processResult(posts, currentAfter: after, currentPosts: self.posts)
                self.updatePosts(postsResult.0, state: postsResult.1)
            case .failure(let error):
                self.viewState.value = .error(error)
            }
        }
    }

    private func processResult(_ posts: [Post],
                               currentAfter: String?,
                               currentPosts: [Post]) -> ([Post], PostsViewState) {
        var allPosts = currentAfter == nil ? [] : currentPosts
        allPosts.append(contentsOf: posts)
        guard !allPosts.isEmpty else { return ([], .empty) }

        let nextAfter = allPosts.last?.fullName
        let newState: PostsViewState = posts.isEmpty ? .populated(allPosts) : .paging(allPosts, after: nextAfter)

        return (allPosts, newState)
    }

}
