//
//  Post.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

class Post: Equatable {

    let id: String
    let title: String
    let kind: String 
    let author: String
    let thumbnail: String?
    let timestamp: Double
    let numberOfComments: Int
    let picture: String?

    var read: Bool = false

    init(id: String, title: String,
         kind: String, author: String,
         thumbnail: String?, timestamp: Double,
         numberOfComments: Int, picture: String?, read: Bool = false) {
        self.id = id
        self.title = title
        self.kind = kind
        self.author = author
        self.thumbnail = thumbnail
        self.timestamp = timestamp
        self.numberOfComments = numberOfComments
        self.picture = picture
        self.read = read
    }

    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }

    var fullName: String {
        return [kind, id].joined(separator: "_")
    }

}
