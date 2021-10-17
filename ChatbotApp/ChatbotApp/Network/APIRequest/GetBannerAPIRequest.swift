//
//  GetBannerAPIRequest.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/04.
//

import Foundation

struct GetBannerAPIRequest: APIRequest {
    func makeRequest(from user: UserIdentifer) throws -> URLRequest {
        guard var components = URLComponents(string: ChatbotAPI.baseURL) else {
            throw ChatbotError.failToMakeURL
        }
        components.path += "banner"
        
        return URLRequest(url: components.url!)
    }
    
    func parseResponse(data: Data) throws -> Banners {
        return try JSONDecoder().decode(Banners.self, from: data)
    }
}
