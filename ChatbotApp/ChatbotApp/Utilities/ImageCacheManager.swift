//
//  ImageCacheManager.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/07.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
