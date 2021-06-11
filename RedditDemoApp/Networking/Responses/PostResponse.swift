//
//  PostInfoResponse.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

struct PostResponse: Decodable {

    let id: String
    let title: String
    let author: String
    let thumbnail: String?
    let url: String?
    let timestamp: Double
    let numberOfComments: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case thumbnail
        case url
        case timestamp = "created"
        case numberOfComments = "num_comments"
    }

}
