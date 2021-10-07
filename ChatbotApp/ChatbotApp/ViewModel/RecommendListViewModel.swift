//
//  RecommendListViewModel.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/04.
//

import Foundation

final class RecommendListViewModel {
    private var apiRequestLoader: APIRequestLoader<GetRecommendListAPIRequest>!
    var currentPage: Int = 1
    var isPaging: Bool = false
    var hasNextPage: Bool = false
    var recommendList: Observable<[Recommend]> = Observable([])
}

extension RecommendListViewModel {
    var numberOfSections: Int {
        return 1
    }
}
