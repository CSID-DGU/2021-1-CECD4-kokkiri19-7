//
//  HomeViewModel.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/09/19.
//

import UIKit

var imagesExample = ["메인화면소식1", "메인화면소식2", "메인화면소식3", "메인화면소식4"]

final class HomeViewModel {
    private var apiRequestLoader: APIRequestLoader<GetBannerAPIRequest>!
    var nicknameLabelText: Observable<String> = Observable("")
    var locationLabelText: Observable<String> = Observable("")
    var bannerImages: Observable<[UIImage]> = Observable([])
    var urls: Observable<[String]> = Observable([])
    var characterImage: Observable<UIImage> = Observable(nil)
    
    func fetch() {
        let getBannerAPIRequest = GetBannerAPIRequest()
        let apiRequestLoader = APIRequestLoader(apiReqeust: getBannerAPIRequest)
        
        guard let email = User.shared.email,
              let nickname = User.shared.nickname else {
                  return
              }
        let userIdentifier = UserIdentifer(email: email, nickname: nickname)
        
        apiRequestLoader.loadAPIReqeust(requestData: userIdentifier) { [weak self] banner, error in
            
            if let error = error {
                print(error)
            }
            
            guard let banner = banner else {
                print("베너 정보 없음")
                return
            }
            
            guard let nickname = User.shared.nickname,
                  let city = User.shared.city,
                  let provicne = User.shared.province else {
                      print("사용자 정보 없음")
                      return
                  }
            
            self?.nicknameLabelText.value = "\(nickname)님 반갑습니다"
            self?.locationLabelText.value = "\(city) \(provicne)의 최근소식"
            self?.urls.value = banner.redirectURLs
            self?.characterImage.value = UIImage(named: "Character")
            
            if let imageURLs = banner.imageURLs {
                for imageURL in imageURLs {
                    self?.downloadImage(url: imageURL)
                }
            }
        }
    }
    
    private func downloadImage(url: String) {
        
    }
}

extension HomeViewModel {
    var numberOfSections: Int {
        return 1
    }
}
