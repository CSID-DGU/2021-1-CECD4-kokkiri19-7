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
        
        guard let email = UserDefaults.standard.object(forKey: "email") as? String,
              let nickname = UserDefaults.standard.object(forKey: "nickname") as? String,
              let city = UserDefaults.standard.object(forKey: "city") as? String,
              let province = UserDefaults.standard.object(forKey: "province") as? String else {
                  print("사용자 정보 없음")
                  return
              }
        
        let userIdentifier = UserIdentifer(email: email, nickname: nickname, province: province)
        
        apiRequestLoader.loadAPIReqeust(requestData: userIdentifier) { [weak self] banner, error in
            
            if let error = error {
                print(error)
            }
            
            guard let banner = banner else {
                print("베너 정보 없음")
                return
            }
            
            self?.nicknameLabelText.value = "\(nickname)님 반갑습니다"
            self?.locationLabelText.value = "\(city) \(province)의 최근소식"
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
        let imageAPIRequest = GetImageAPIRequest()
        let apiRequestLoader = APIRequestLoader(apiReqeust: imageAPIRequest)
        
        let cacheKey = NSString(string: url)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.bannerImages.value?.append(cachedImage)
            return
        }
        
        apiRequestLoader.loadAPIReqeust(requestData: url) { [weak self] image, error in
            if let error = error {
                print(error)
            }
            
            guard let image = image else {
                return
            }
            
            ImageCacheManager.shared.setObject(image, forKey: cacheKey)
            self?.bannerImages.value?.append(image)
        }
    }
    
    func test() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            var images = [UIImage]()
            for name in imagesExample {
                images.append(UIImage(named: name)!)
            }
            
            guard let nickname = UserDefaults.standard.object(forKey: "nickname") as? String,
                  let city = UserDefaults.standard.object(forKey: "city") as? String,
                  let province = UserDefaults.standard.object(forKey: "province") as? String else {
                      print("사용자 정보 없음")
                      return
                  }
            
            self.nicknameLabelText.value = "\(nickname)님 반갑습니다"
            self.locationLabelText.value = "\(city) \(province)의 최근소식"
            self.urls.value = ["https://www.junggu.seoul.kr/content.do?cmsid=15229",
                               "http://www.junggu.seoul.kr/index.jsp#",
                               "https://xn--ob0bj71amzcca52h0a49u37n.kr/ui/main.html",
                               "https://blog.naver.com/junggu4u/222548859711",
                               "http://www.junggu.seoul.kr/index.jsp#",
                               "http://www.junggu.seoul.kr/content.do?cmsid=15225",
                               "http://www.junggu.seoul.kr/content.do?cmsid=15197",
                               "https://www.junggu.seoul.kr/content.do?cmsid=15229",
                               "https://www.junggu.seoul.kr/content.do?cmsid=15229"]
            self.characterImage.value = UIImage(named: "Character")
            
            let imageURLs = ["http://www.junggu.seoul.kr/main/14236_image_1.jpg",
                             "http://www.junggu.seoul.kr/main/14236_image_2.jpg",
                             "http://www.junggu.seoul.kr/main/14236_image_3.jpg",
                             "http://www.junggu.seoul.kr/main/14236_image_4.jpg",
                             "http://www.junggu.seoul.kr/main/14236_image_5.jpg",
                             "http://www.junggu.seoul.kr/main/14236_image_6.jpg",
                             "http://www.junggu.seoul.kr/main/14236_image_23.jpg",
                             "http://www.junggu.seoul.kr/main/14236_image_1.jpg"
            ]
            for imageURL in imageURLs {
                self.downloadImage(url: imageURL)
            }
        }
    }
}

extension HomeViewModel {
    var numberOfSections: Int {
        return 1
    }
}
