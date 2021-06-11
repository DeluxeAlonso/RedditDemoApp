//
//  PostDetailProtocols.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

protocol PostDetailCoordinatorProtocol: AnyObject {}

protocol PostDetailViewModelProtocol {

    var author: String { get }
    var title: String { get }
    
}
