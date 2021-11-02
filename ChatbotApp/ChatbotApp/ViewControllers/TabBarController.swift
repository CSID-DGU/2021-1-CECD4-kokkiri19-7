//
//  TabBarController.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/09/14.
//

import UIKit
import UserNotifications
import KakaoSDKAuth
import KakaoSDKUser

final class TabBarController: UITabBarController {
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestNotificationAuthorization()
        sendNotification(seconds: 60)
        
        registerNotification()
        
        // 로그아웃을 하면 app에 있던 토큰을 삭제하게 되어서 hasToken() -> false
        // 그렇지 않고 로그인했던 상태로 로그아웃하지 않으면 hasToken()이 있는 상태임... -> 이 말은 곧 hasToken()이 있으면 서버에서 받아올까?
        // hasToken()이 없으면 어짜피 서버로 보낼테고 있으면 있는것 없으면 새로 저장.. 
        if AuthApi.hasToken() { // 단지 한번이라도 토큰을 발급받은적이 있는지를 확인하는 것임.. 따라서 있다한들 로그인이 되어있다는 것을 확인하지 못함..
            print(AuthApi.hasToken())
            self.selectedIndex = 0
        }
        else {
            self.selectedIndex = 3
        }
        
    }
    
    private func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    private func sendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "새로운 혜택, 소식이 올라왔습니다."
        notificationContent.body = "자세히 보려면 해당 알림을 클릭하면 됩니다."
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)
        let request = UNNotificationRequest(identifier: "추천 알림",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print(error)
            }
        }
    }
    
    //MARK:- Notification
    private func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveCancelButtonTouchedUp), name: NSNotification.Name.CancelButtonTouchedUp, object: nil)
    }
    
    @objc private func didReceiveCancelButtonTouchedUp(_ sender: Notification) {
        self.selectedIndex = 0
    }
}

extension Notification.Name {
    static let CancelButtonTouchedUp = Notification.Name("CancelButtonTouchedUp")
}
