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
    
    func test() {
        let firstContent = """
지원내용: 산모신생아 건강관리 지원사업을 이용하는 서울시 자격확인 대상 출산가정에 본인부담금 90%를 추가로 지원

주관부서문의처: 건강관리과 지역보건팀 ☎ 3396-6358, 3396-6354

지원대상: 서울시 자격확인 대상 출산가정 ※산모 또는 배우자가 기초생활수급자 또는 차상위계층

신청절차: 서비스 종료일 30일 이내 보건소 신청→ 지원

구비서류: 통장사본
"""
        let secondContent = """
지원내용: 매월 3만원

주관부서문의처: 중구청 사회복지과 장애인복지팀 02-3396-5373

지원대상: 신청일 기준 주민등록상 주소지가 '서울특별시 중구'인 장애정도가 '심한 장애'인 중 '국민기초생활수급자' 또는 '차상위 장애인'에 해당하는 사람

신청절차: 거주지 동 주민센터에 신청

구비서류: 신분증, 신청서류, 지급계좌 통장사본 등
"""
        let thirdContent = """
제9회 한양도성문화제가 10월1일(금)부터∼10일(일)까지 한양도성 유적전시관과 도성 일원에서 비대면으로 개최된다.
올해 주제는 ‘순성, 바람을 담다’로 코로나시기를 잘 극복하기 위한 염원을 각 프로그램에 담았다. 올해 순성(도성을 따라 걷는 것) 프로그램은 비대면으로 진행된다. 공식홈페이지에서 비대면 순성키트를 신청한 후, 개별적으로 참여할 수 있다. 주 행사장인 유적전시관에서는 남산 분수대 유적을 활용한 ‘바람을 싣어 나르는 소원 쪽배’가 야간프로그램으로 운영된다. 도성을 쌓을 때 과정과 참여자들의 기록이 담긴 ‘각자’를 모티브로 한 시민참여 아트월 작품 ‘우리의 기록, 문화제를 만들다’도 유적전시관에서 만날 수 있다.
한편, 코스모스로 유명한 인왕순성길은 ‘명상걷기 오디오프로그램’과 결합되어 치유와 휴식의 공간으로 재탄생된다. 이 밖에도 유투버와 함께하는 ‘랜선 순성’, 어린이와 외국인을 위한 온라인 골든벨과 말하기대회, vlog영상 공모전 ‘내가 그리는 도성 순성길’ 등 다양한 프로그램이 준비되어 있다. 모든 프로그램은 비대면으로 운영된다.
"""
        
        let recommend1 = Recommend(title: "서울현 산모*신생아 건강관리 지원사업[본인부담금 지원] ",
                                   classification: "복지",
                                   content: firstContent,
                                   summary: "지원내용: 산모신생아 건강관리 지원사업을 이용하는 서울시 자격확인 대상 출산가정에 본인부담금 90%를 추가로 지원",
                                   image: nil,
                                   url: "http://www.junggu.seoul.kr/content.do?cmsid=14386")
        
        let recommend2 = Recommend(title: "저소득 중증장애인 교통비 지원",
                                   classification: "복지",
                                   content: secondContent,
                                   summary: "지원내용: 매월 3만원",
                                   image: nil,
                                   url: "http://www.junggu.seoul.kr/content.do?cmsid=14386")
        
        let recommend3 = Recommend(title: "한양도성문화제",
                                   classification: "관광",
                                   content: thirdContent,
                                   summary: thirdContent,
                                   image: "http://tong.visitkorea.or.kr/cms/resource/76/2741576_image2_1.JPG",
                                   url:"http://www.junggu.seoul.kr/tour/content.do?cmsid=14987&contentId=1948539")
        
        let recommends = [recommend1, recommend2, recommend3, recommend1, recommend2, recommend3,recommend1, recommend2, recommend3, recommend1, recommend2, recommend3,]
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
            self.recommendList.value? = recommends
        }
    }
}

extension RecommendListViewModel {
    var numberOfSections: Int {
        return 1
    }
}
