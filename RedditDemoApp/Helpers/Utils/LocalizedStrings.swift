//
//  LocalizedStrings.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import Foundation

protocol Localizable {

    var tableName: String { get }
    var localized: String { get }

}

extension Localizable where Self: RawRepresentable, Self.RawValue == String {

    var localized: String {
        return rawValue.localized(tableName: tableName)
    }

}

enum LocalizedStrings: String, Localizable {

    case welcome
    case login
    case topPostsTItle
    case savePictureSuccess
    case dismiss
    case emptyPostsTitle

    var tableName: String {
        return "Localizable"
    }

    func callAsFunction() -> String {
        return self.localized
    }

}

extension String {

    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self,
                                 tableName: tableName,
                                 bundle: bundle,
                                 value: self,
                                 comment: "")
    }

}
