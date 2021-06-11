//
//  Dequeuable.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import UIKit

protocol Dequeuable {

    static var dequeuIdentifier: String { get }

}

extension Dequeuable where Self: UIView {

    static var dequeuIdentifier: String {
        return String(describing: self)
    }

}

extension UITableViewCell: Dequeuable { }
