//
//  ChatbotViewController.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/05/28.
//

import UIKit
import Kommunicate

class ChatbotViewController: UIViewController {
    @IBOutlet weak var loadingIndicatorView: UIActivityIndicatorView!
    let kmUser = KMUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureChatbot()
        setupNotificationCenter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpLoadingIndicatorView()
        startChatbot()
    }
    
    //MARK: - start chatbot
    private func startChatbot() {
        if Kommunicate.isLoggedIn {
            createConversation()
        }
        else {
            registerUser()
            createConversation()
        }
    }
    
    private func createConversation() {
        let botId = ["--ovayc"]
//        guard let email = UserDefaults.standard.object(forKey: "email") as? String else {
//            return
//        }
        let kmConversation = KMConversationBuilder()
            .withBotIds(botId)
            .useLastConversation(false)
            .build()
        
        Kommunicate.createConversation(conversation: kmConversation) { result in
            switch result {
            case .success(let conversationID):
                print("Conversation id: ", conversationID)
                Kommunicate.showConversationWith(groupId: conversationID,
                                                 from: self) { success in

                }
            case.failure(let kmConversationError):
                print(kmConversationError)
            }
        }
        
//        Kommunicate.createConversation(
//            userId: email,
//            botIds: botId,
//            useLastConversation: false,
//            completion: { response in
//                guard !response.isEmpty else {return}
//                Kommunicate.showConversationWith(groupId: response, from: self, completionHandler: { success in
//                })
//            })
    }
    
    private func registerUser() {
        guard let email = UserDefaults.standard.object(forKey: "email") as? String,
              let nickname = UserDefaults.standard.object(forKey: "nickname") as? String else {
                  return
              }
        kmUser.userId = email
        kmUser.displayName = nickname
        kmUser.applicationId = Configuration.AppID
        
        Kommunicate.registerUser(kmUser) { response, error in
            guard error == nil else {
                return
            }
            print("로그인에 성공하였습니다.")
        }
    }
    
    //MARK: - configure chatbot
    private func configureChatbot() {
        Kommunicate.defaultConfiguration.backgroundColor = .white
        setupChatbotNavigationBar()
        setupChatbotMessage()
        setupChatbar()
    }
    
    private func setupChatbotNavigationBar() {
        let kmNavigationBarProxy = UINavigationBar.appearance(whenContainedInInstancesOf: [KMBaseNavigationViewController.self])
        kmNavigationBarProxy.isTranslucent = false
        // Navigation Bar's Background Color
        kmNavigationBarProxy.barTintColor = UIColor.chatBackgroundStart
        // Navigation Bar's Tint color
        kmNavigationBarProxy.tintColor = UIColor.white
        // Navigation Bar's Title color
        kmNavigationBarProxy.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        Kommunicate.defaultConfiguration.hideFaqButtonInConversationList = true // Hide from Conversation List screen
        Kommunicate.defaultConfiguration.hideFaqButtonInConversationView = true // Hide from Conversation screen
    }
    
    private func setupChatbotMessage() {
        KMMessageStyle.receivedBubble.color = UIColor.systemGray5
        KMMessageStyle.receivedMessage = KMStyle(font: .systemFont(ofSize: 16), text: .black)
        KMMessageStyle.time = KMStyle(font: .systemFont(ofSize: 12), text: .black)
        
        KMMessageStyle.sentBubble.color = UIColor.mainGreen
        KMMessageStyle.sentMessage = KMStyle(font: .systemFont(ofSize: 16), text: .black)
    }
    
    private func setupChatbar() {
        // To hide all the attachment options
        Kommunicate.defaultConfiguration.chatBar.optionsToShow = .none
        Kommunicate.defaultConfiguration.hideAudioOptionInChatBar = true
    }
    
    //MARK: - setup LoadingIndicatorView
    private func setUpLoadingIndicatorView() {
        self.view.bringSubviewToFront(loadingIndicatorView)
        loadingIndicatorView.color = .grey100
        loadingIndicatorView.startAnimating()
    }
    
    //MARK: - setup Notification
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveConversationClosed),
                                               name: Notification.Name(rawValue: "ConversationClosed"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveConversationLaunched),
                                               name: Notification.Name(rawValue: "ConversationLaunched"),
                                               object: nil)
    }
    
    @objc func didReceiveConversationLaunched(_ notification: Notification) {
        self.loadingIndicatorView.stopAnimating()
    }
    
    @objc func didReceiveConversationClosed(_ notification: Notification) {
        _ = self.tabBarController?.selectedIndex = 0
    }
}
