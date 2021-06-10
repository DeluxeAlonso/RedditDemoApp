//
//  URLRequest+Headers.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

extension URLRequest {

    mutating func setJSONContentType() {
        setValue("application/json; charset=utf-8",
                 forHTTPHeaderField: "Content-Type")
    }

    mutating func setHeader(for httpHeaderField: String, with value: String) {
        setValue(value, forHTTPHeaderField: httpHeaderField)
    }

}
