//
//  ImageCacheProtocol.swift
//  MovieApplication
//
//  Created by Gaurav Arora on 9/30/22.
//

import Foundation
import UIKit

protocol ImageCacheProtocol {
    func getImageCache() -> NSCache<AnyObject, UIImage>
}
