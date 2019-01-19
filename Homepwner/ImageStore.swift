//
//  ImageStore.swift
//  Homepwner
//
//  Created by Sam Reaves on 1/19/19.
//  Copyright © 2019 Sam Reaves Digital. All rights reserved.
//

import UIKit

class ImageStore {
    
    /* Cache will store images by string key */
    let cache = NSCache<NSString, UIImage>()
    
    /* Add image to cache */
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    /* Get image from cache */
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    /* Delete image */
    func deleteImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
