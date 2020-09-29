//
//  ImageViewExtension.swift
//  iTunesSearch
//
//  Created by Cengizhan Özcan on 9/22/20.
//  Copyright © 2020 Cengizhan Özcan. All rights reserved.
//

import UIKit.UIImageView

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func loadImage(urlString: String) {
        
        if let cacheImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if let _ = error {
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else { return }
            imageCache.setObject(image, forKey: urlString as AnyObject)
            
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        }.resume()

    }
}
