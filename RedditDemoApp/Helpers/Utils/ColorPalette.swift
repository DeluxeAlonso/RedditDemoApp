//
//  ColorPalette.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import UIKit

extension UIColor {

    convenience init(withIntRed red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let maxColorValue: CGFloat = 255

        let floatRed = red / maxColorValue
        let floatGreen = green / maxColorValue
        let floatBlue = blue / maxColorValue

        self.init(red: floatRed, green: floatGreen, blue: floatBlue, alpha: alpha)
    }

}

struct ColorPalette {

    static let lightBlueColor = UIColor(withIntRed: 74, green: 144, blue: 226, alpha: 1)
    static let darkBlueColor = UIColor(withIntRed: 0, green: 101, blue: 163, alpha: 1)
    static let lightGrayColor = UIColor(withIntRed: 205, green: 205, blue: 205, alpha: 1)
    static let redColor = UIColor(withIntRed: 255, green: 94, blue: 112, alpha: 1)
    static let grayColor = UIColor(withIntRed: 130, green: 130, blue: 130, alpha: 1)
    static let whiteColor = UIColor(white: 249 / 255, alpha: 1)
    static let blackColor = UIColor(white: 40 / 255, alpha: 1)
    static let darkGrayColor = UIColor.darkGray
    static let orangeColor = UIColor(withIntRed: 251, green: 38, blue: 21, alpha: 1)

}
