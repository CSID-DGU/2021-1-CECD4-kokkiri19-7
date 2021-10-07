//
//  RecommendDetailViewController.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/07.
//

import UIKit

final class RecommendDetailViewController: UIViewController {
    static let identifier = "RecommendDetailViewController"
    private var recommend: Recommend?
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var goButton: UIButton!
    @IBOutlet private weak var navigationTitleItem: UINavigationItem!
    @IBOutlet private weak var gobackButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
