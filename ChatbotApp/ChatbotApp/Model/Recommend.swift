//
//  Recommend.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/04.
//

import Foundation

struct Recommend: Decodable {
    let title: String
    let classification: String
    let content: String
    let url: String
}
