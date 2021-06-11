//
//  UIImageView+Caching.swift
//  RedditDemoApp
//
//  Created by Alonso on 11/06/21.
//

import UIKit

var imageCache = NSCache<NSURL, UIImage>()

extension UIImageView {

    func setImage(from url: URL, with placeholder: UIImage? = nil) {

        if let cached = imageCache.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                self.image = cached
            }
            return
        }

        self.image = placeholder
        let task = URLSession.shared.dataTask(with: url)  { (data, _, _) in
            if let data = data, let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: url as NSURL)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
        task.resume()
    }

}
