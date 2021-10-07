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
    
    func fetch() {
        let getRecommendListAPIRequest = GetRecommendListAPIRequest()
        apiRequestLoader = APIRequestLoader(apiReqeust: getRecommendListAPIRequest)
        
        guard let email = User.shared.email,
              let nickname = User.shared.nickname else {
                  return
              }
        let userIdentifier = UserIdentifer(email: email, nickname: nickname)
        
        apiRequestLoader.loadAPIReqeust(requestData: userIdentifier) { [weak self] recommendList, error in
            if let error = error {
                print(error)
            }
            
            guard let recommendList = recommendList, recommendList.recommends.count > 0 else {
                self?.hasNextPage = false
                return
            }
            
            self?.hasNextPage = true
            _ = recommendList.recommends.compactMap({ recommend in
                self?.recommendList.value?.append(recommend)
            })
        }
    }
}

extension RecommendListViewModel {
    var numberOfSections: Int {
        return 1
    }
}
