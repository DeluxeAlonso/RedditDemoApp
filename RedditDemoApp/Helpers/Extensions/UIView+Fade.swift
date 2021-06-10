//
//  UIView+Fade.swift
//  RedditDemoApp
//
//  Created by Alonso on 10/06/21.
//

import UIKit

extension UIView {

    /**
     * Fade in animation.
     */
    func fadeIn(_ duration: TimeInterval, to alpha: CGFloat = 1.0) {
      UIView.animate(withDuration: duration, animations: {
        self.alpha = alpha
      })
    }

    /**
     * Fade out animation.
     */
    func fadeOut(_ duration: TimeInterval) {
      UIView.animate(withDuration: duration, animations: {
        self.alpha = 0.0
      })
    }

}
