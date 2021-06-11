//
//  PostPictureDetailViewModel.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import Foundation

final class PostPictureDetailViewModel: PostPictureDetailViewModelProtocol {

    private var pictureURL: URL?

    // MARK: - Initializers

    init(pictureURL: URL?) {
        self.pictureURL = pictureURL
    }

    // MARK: - PostPictureDetailViewModelProtocol

    var pictureURLRequest: URLRequest? {
        guard let pictureURL = pictureURL else { return nil }
        return URLRequest(url: pictureURL)
    }

}
