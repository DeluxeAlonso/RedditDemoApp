//
//  String+Base64.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

extension String {

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}
