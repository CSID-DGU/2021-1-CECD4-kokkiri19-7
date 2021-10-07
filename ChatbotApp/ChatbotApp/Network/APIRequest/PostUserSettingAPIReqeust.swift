//
//  PostUserSettingAPIReqeust.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/07.
//

import Foundation

struct PostUserSettingAPIReqeust: APIRequest {
    func makeRequest(from user: UserSetting) throws -> URLRequest {
        guard var components = URLComponents(string: ChatbotAPI.baseURL) else {
            throw ChatbotError.failToMakeURL
        }
        components.path += "users/new"
        
        return URLRequest(url: components.url!)
    }
    
    func parseResponse(data: Data) throws {
        return
    }
}
