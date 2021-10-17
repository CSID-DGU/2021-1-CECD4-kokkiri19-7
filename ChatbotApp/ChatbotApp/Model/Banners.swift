//
//  Banners.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/04.
//

import Foundation

struct Banners: Decodable {
    let imageURLs: [String]?
    let redirectURLs: [String]?
    
    enum CodingKeys: String, CodingKey {
        case imageURLs = "images"
        case redirectURLs = "urls"
    }
}
