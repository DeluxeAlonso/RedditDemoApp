//
//  Post+MockInitializer.swift
//  RedditDemoAppTests
//
//  Created by Alonso on 11/06/21.
//

import Foundation
@testable import RedditDemoApp

extension Post {

    static func with(id: String = "testId",
                     title: String = "post 1",
                     kind: String = "t3",
                     author: String = "Alonso",
                     thumbnail: String? = nil,
                     timestamp: Double = 12345678,
                     numberOfComments: Int = 100,
                     picture: String? = nil) -> Post {
        return Post(id: id,
                    title: title,
                    kind: kind,
                    author: author,
                    thumbnail: thumbnail,
                    timestamp: timestamp,
                    numberOfComments: numberOfComments,
                    picture: picture)
    }

}
