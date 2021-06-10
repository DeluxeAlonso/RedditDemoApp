//
//  Notification+RawRepresentable.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import Foundation

extension RawRepresentable where RawValue == String, Self: NotificationNameable {

    var name: Notification.Name {
        get {
            return Notification.Name(self.rawValue)
        }
    }

}
