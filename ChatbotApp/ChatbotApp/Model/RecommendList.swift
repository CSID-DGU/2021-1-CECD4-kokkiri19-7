//
//  RecommendList.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/04.
//

import Foundation

struct RecommendList: Decodable {
    let page: Int
    let recommends: [Recommend]
}
