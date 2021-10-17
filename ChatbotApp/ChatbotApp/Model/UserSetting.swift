//
//  UserSetting.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/07.
//

import Foundation

struct UserSetting: Codable {
    let email: String
    let nickname: String
    let gender: String?
    let age: Int?
    let birthday: Date?
    let city: String?
    let province: String?
}
