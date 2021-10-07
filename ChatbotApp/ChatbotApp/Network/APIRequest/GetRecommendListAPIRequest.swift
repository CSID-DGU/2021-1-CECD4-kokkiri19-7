//
//  GetRecommendListAPIRequest.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/04.
//

import Foundation

struct GetRecommendListAPIRequest: APIRequest {
    func makeRequest(from user: UserIdentifer) throws -> URLRequest {
        guard var components = URLComponents(string: ChatbotAPI.baseURL) else {
            throw ChatbotError.failToMakeURL
        }
        components.path += ""
        
        return URLRequest(url: components.url!)
    }
    
    func parseResponse(data: Data) throws -> Recommend {
        return try JSONDecoder().decode(Recommend.self, from: data)
    }
}
