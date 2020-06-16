//
//  AsyncImageView.swift
//  Albums
//
//  Created by Yogesh on 16.06.20.
//  Copyright © 2020 Yogesh. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class AsyncImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImage(urlString: String) {
        
        self.imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        ImageDownloadService.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                if self.imageUrlString == urlString {
                    self.image = UIImage(data: data)
                }
            case .failure(_):
                self.image = UIImage(named: "noImage")
            }
        }
    }
}
