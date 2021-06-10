//
//  ErrorDescriptable.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

protocol Descriptable {

    var description: String { get }

}

protocol ErrorDescriptable: Descriptable {}
