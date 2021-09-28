//
//  HomeViewModel.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/09/19.
//

import UIKit

var imagesExample = ["메인화면소식1", "메인화면소식2", "메인화면소식3", "메인화면소식4"]

final class HomeViewModel {
    var nicknameLabelText: Observable<String> = Observable("")
    var locationLabelText: Observable<String> = Observable("")
    var bannerImages: Observable<[UIImage]> = Observable([])
    var urls: Observable<[String]> = Observable([])
    var characterImage: Observable<UIImage> = Observable(nil)
    
    func fetch() {
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
            var images = [UIImage]()
            for name in imagesExample {
                images.append(UIImage(named: name)!)
            }
            
            self.bannerImages.value = images
            self.characterImage.value = UIImage(named: "Character")
            self.nicknameLabelText.value = "연정민님 안녕하세요"
            self.locationLabelText.value = "서울시 중구청 새로운 소식입니다"
            
            self.urls.value = ["https://www.google.co.kr", "https://www.naver.com", "https://jryoun1.github.io", "https://www.junggu.seoul.kr/html/jg4u_2109.html"]
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
