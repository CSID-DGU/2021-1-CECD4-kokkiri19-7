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
        
        guard let email = UserDefaults.standard.object(forKey: "email") as? String,
              let nickname = UserDefaults.standard.object(forKey: "nickname") as? String,
              let province = UserDefaults.standard.object(forKey: "province") as? String else {
                  print("사용자 정보 없음")
                  return
              }
        
        let userIdentifier = UserIdentifer(email: email, nickname: nickname, province: province)
        
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
지원내용: 실업급여를 받는 실업자에게 국민연금보험료를 지원해 주는 사회적제도로 실업기간에도 보험료를 납입함으로써 노후대비를 할 수 있도록 도움을 주는 제도

지원기간 : 구직급여를 받는 기간 중 지원 (최대 1년)

지원방법 : 본인부담분 25%를 납부하면 국민연금 보험료의 75%지원

주관부서문의처: 국민연금관리공단 국번 없이 ☎ 1355 또는 고용센터 국번 없이 ☎ 1350

지원대상: 국민연금 가입자 또는 가입자였던 자 중 18세 이상 60세 미만으로 구직급여를 받는 분 단, 고소득자와 고액재산가의 경우 지원 대상에서 제외
"""
        let secondContent = """
지원내용: 자치구 구인기업과 구직자의 만남의 날을 지정 운영

주관부서문의처: 도심산업과 일자리경제팀 ☎ 3396-5682

지원대상: 구인기업 및 구직자

신청절차: 구인기업 신청 - 직종별 구직자 모집 및 알선 - 희망취업 일구데이 행사진행 후 미취업자 사후관리 - 중구일자리플러스센터(☎3396-5684~6) 신청
"""
        let thirdContent = """
지원내용: 1. 직업교육훈련 과정 운영
2. 취업 상담 및 알선
3. 취업맞춤대비 집단상담 운영
4. 새일여성인턴제 지원
5. 취업 후 사후관리 서비스 제공

주관부서문의처: 중구 여성새로일하기센터 ☎ 2234-3130

지원대상: 취업의지가 확고한 경력단절여성

신청절차: 중구 다산로 32길 5 중구여성플라자 3층, 새일센터팀 방문접수 (청구역 2번 출구) - 홈페이지 : www.jgwoman.or.kr
"""
        
        let fourthContent = """
지원내용: 긴급하고 일시적인 돌봄이 필요한 주민을 돌봄 SOS매니저가 방문하여 돌봄욕구 파악 및 서비스 계획, 결정하여 협약된
돌봄서비스 기관에 의뢰하여 맞춤형 돌봄서비스 제공

- 돌봄서비스 유형
 · 일시재가 : 대상자 가정방문, 당사자 수발
 · 단기시설 : 단기시설 입소 · 식사지원 : 기본적 식생활 유지위한 반찬, 도시락 등 식사배달
 · 정보상담 : 돌봄관련 문제상담, 서비스 기관 정보제공
 · 동행지원 : 필수적인 외출활동지원, 병원동행
 · 건강지원 : 건강상담, 검사, 투약 등 종합적 의료 관리

지원대상: 어르신·장애인·만50세이상 중장년 가구 (만19세 ~49세까지 긴급돌봄 필요시 예외지원) ① 혼자 거동하기 어렵거나 독립적 일상생활 수행이 어려운 경우 ② 수발할 수 있는 가족 등이 부재하거나, 수발할 수 없는 경우 ③ 공적 돌봄서비스를 이용하지 않거나, 서비스 이용중 불가피한 공백이 발생한 경우 ※ 위의 세 가지 조건을 모두 충족한 경우 적격

이용요금: 기준 중위소득 85%이하 전액지원. 이외 자부담 (1인 연간 최대 지원금액 : 1,580,000원)

신청절차: 주소지 동주민센터 방문신청
"""
        let fifthContent = """
지원내용: 위기가정의 정서·법률·경제·의료 등 근본적인 문제해결을 통하여 폭력의 재발을 예방
상담 및 모니터링 진행, 서비스 연계 등

주관부서문의처: 복지지원과 맞춤지원팀 ☎ 3396-5316~8

지원대상: 가정폭력으로 112 신고된 가구 중 정보제공에 동의한 피해자

신청절차: 이용안내 상담원과 사례관리사가 112신고된 가구(개인정보제공동의자)에 개별 연락하여 전화 상담, 필요시 방문 상담
"""
        
        let sixthContent = """
2021.10.22 ~ 2021.11.14
■ 예술가와의 대화 10.31.(일) 공연 종료 후, 객석
- 참석: 구자혜(연출), 성수연 전박찬(배우)
- 수어통역, 한글자막 서비스 제공
* 참석자는 변경될 수 있습니다.

장소
명동예술극장
장르
연극
공연시간
평일 19시/ 토, 일 15시 (화 공연없음)
*전회차 배리어프리 서비스(수어통역, 음성해설, 한글자막) 제공
입장권
R석 5만원, S석 3만5천원, A석 2만원
*동반자 외 좌석 한 칸 띄어 앉기 시범운영
소요시간
175분 (인터미션 15분 포함) ※변경될 수 있음
문의
1644-2003
관람연령
8세 이상 관람가 (초등학생 이상)
*일부 장면에서 비속어 표현 및 죽음에 대한 묘사를 포함합니다.
자막
영문자막 매주 목, 일요일
English subtitles will be provided on Thursdays and Sundays.
작
구자혜
연출
구자혜
출연
고애리 문예주 박경구 박소연 백우람 성수연 이리 이상홍 이유진 전박찬 최순진
"""
        
        let seventhContent = """
제9회 한양도성문화제가 10월1일(금)부터∼10일(일)까지 한양도성 유적전시관과 도성 일원에서 비대면으로 개최된다.
올해 주제는 ‘순성, 바람을 담다’로 코로나시기를 잘 극복하기 위한 염원을 각 프로그램에 담았다. 올해 순성(도성을 따라 걷는 것) 프로그램은 비대면으로 진행된다. 공식홈페이지에서 비대면 순성키트를 신청한 후, 개별적으로 참여할 수 있다. 주 행사장인 유적전시관에서는 남산 분수대 유적을 활용한 ‘바람을 싣어 나르는 소원 쪽배’가 야간프로그램으로 운영된다. 도성을 쌓을 때 과정과 참여자들의 기록이 담긴 ‘각자’를 모티브로 한 시민참여 아트월 작품 ‘우리의 기록, 문화제를 만들다’도 유적전시관에서 만날 수 있다.
한편, 코스모스로 유명한 인왕순성길은 ‘명상걷기 오디오프로그램’과 결합되어 치유와 휴식의 공간으로 재탄생된다. 이 밖에도 유투버와 함께하는 ‘랜선 순성’, 어린이와 외국인을 위한 온라인 골든벨과 말하기대회, vlog영상 공모전 ‘내가 그리는 도성 순성길’ 등 다양한 프로그램이 준비되어 있다. 모든 프로그램은 비대면으로 운영된다.
"""
        
        let recommend1 = Recommend(title: "국민연금 실업크레딧",
                                   classification: "중장년",
                                   content: firstContent,
                                   summary: "지원내용: 실업급여를 받는 실업자에게 국민연금보험료를 지원해 주는 사회적제도로 실업기간에도 보험료를 납입함으로써 노후대비를 할 수 있도록 도움을 주는 제도",
                                   image: nil,
                                   url: "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=F")
        
        let recommend2 = Recommend(title: "희망취업 일구데이 운영",
                                   classification: "중장년",
                                   content: secondContent,
                                   summary: "지원내용: 자치구 구인기업과 구직자의 만남의 날을 지정 운영",
                                   image: nil,
                                   url: "http://www.junggu.seoul.kr/content.do?cmsid=14386")
        
        let recommend3 = Recommend(title: "경력단절 여성취업지원",
                                   classification: "중장년",
                                   content: thirdContent,
                                   summary: """
                                   지원내용: 1. 직업교육훈련 과정 운영
                                   2. 취업 상담 및 알선
                                   3. 취업맞춤대비 집단상담 운영
                                   4. 새일여성인턴제 지원
                                   5. 취업 후 사후관리 서비스 제공
                                   """,
                                   image: nil,
                                   url: "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=F")
        
        let recommend4 = Recommend(title: "돌봄 SOS센터",
                                    classification: "전생애주기",
                                    content: fourthContent,
                                    summary: "지원내용: 긴급하고 일시적인 돌봄이 필요한 주민을 돌봄 SOS매니저가 방문하여 돌봄욕구 파악 및 서비스 계획, 결정하여 협약된 돌봄서비스 기관에 의뢰하여 맞춤형 돌봄서비스 제공",
                                       image: nil,
                                       url: "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=H")
    
        let recommend5 = Recommend(title: "위기가정 통합지원센터 운영",
                                   classification: "전생애주기",
                                   content: fifthContent,
                                   summary: "지원내용: 위기가정의 정서·법률·경제·의료 등 근본적인 문제해결을 통하여 폭력의 재발을 예방 상담 및 모니터링 진행, 서비스 연계 등",
                                   image: nil,
                                   url: "http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=H")
        
        let recommend6 = Recommend(title: "로드킬 인 더 씨어터",
                                   classification: "공연·전시",
                                   content: sixthContent,
                                   summary: sixthContent,
                                   image: "http://www.ntck.or.kr/upload/perfMain/21100109232706626007.jpg",
                                   url: "http://www.ntck.or.kr/ko/performance/info/256990")
        
        let recommend7 = Recommend(title: "한양도성문화제",
                                   classification: "행사·축제",
                                   content: seventhContent,
                                   summary: seventhContent,
                                   image: "http://tong.visitkorea.or.kr/cms/resource/76/2741576_image2_1.JPG",
                                   url:"http://www.junggu.seoul.kr/tour/content.do?cmsid=14987&contentId=1948539")
        

        let recommends = [recommend1, recommend2, recommend3, recommend4, recommend5, recommend6, recommend7]
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.recommendList.value? = recommends
        }
    }
}

extension RecommendListViewModel {
    var numberOfSections: Int {
        return 1
    }
}
