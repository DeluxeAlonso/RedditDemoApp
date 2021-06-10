//
//  URL+QueryParameters.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

extension URL {
    
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }

}
