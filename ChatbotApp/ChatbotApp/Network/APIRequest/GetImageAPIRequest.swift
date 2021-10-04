//
//  GetImageAPIRequest.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/04.
//

import UIKit

struct GetImageAPIRequest: APIRequest {
    func makeRequest(from imageURL: String) throws -> URLRequest {
        guard let url = URL(string: imageURL) else {
            throw ChatbotError.failToMakeURL
        }
        
        return URLRequest(url: url)
    }
    
    func parseResponse(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            return UIImage()
        }
        return image
    }
}
