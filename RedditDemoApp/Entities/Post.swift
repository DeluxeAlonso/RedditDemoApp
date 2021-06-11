//
//  Post.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

struct Post: Equatable {

    let id: String
    let title: String
    let kind: String 
    let author: String
    let thumbnail: String?
    let timestamp: Double
    let numberOfComments: Int
    let picture: String?

    var read: Bool = false

    var fullName: String {
        return [kind, id].joined(separator: "_")
    }

}
