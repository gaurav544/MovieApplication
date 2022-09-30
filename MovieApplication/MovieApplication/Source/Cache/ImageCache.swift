//
//  ImageCache.swift
//  MovieApplication
//
//  Created by Gaurav Arora on 9/30/22.
//

import Foundation
import UIKit

final class ImageCache: ImageCacheProtocol {
    var imageCache: NSCache<AnyObject, UIImage> = NSCache<AnyObject, UIImage>()
    static var shared = ImageCache()
    
    private init() {}
    
    func getImageCache() -> NSCache<AnyObject, UIImage> {
        return imageCache
    }
}
