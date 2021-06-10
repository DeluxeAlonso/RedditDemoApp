//
//  Storyboarded.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

protocol Storyboarded {

    static var storyboardName: String { get }
    static func instantiate() -> Self

}

extension Storyboarded where Self: UIViewController {

    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]

        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)

        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }

}
