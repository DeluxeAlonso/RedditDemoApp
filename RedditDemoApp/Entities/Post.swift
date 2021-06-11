//
//  Post.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

struct Post: Decodable, Equatable {

    let title: String
    let author: String
    let thumbnail: String
    let timestamp: Double
    let numberOfComments: Int

    var read: Bool = false

    enum CodingKeys: String, CodingKey {
        case title
        case author
        case thumbnail
        case timestamp = "created"
        case numberOfComments = "num_comments"
    }

}
