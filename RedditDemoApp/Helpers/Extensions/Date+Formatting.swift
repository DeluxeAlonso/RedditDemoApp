//
//  Date+Formatting.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import Foundation

extension Date {

    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }

}
