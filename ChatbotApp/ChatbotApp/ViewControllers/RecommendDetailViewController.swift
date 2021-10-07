//
//  RecommendDetailViewController.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/07.
//

import UIKit
import SafariServices

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
        configureView()
    }
    
    private func configureView() {
        self.titleLabel.text = recommend?.title
        self.contentLabel.text = recommend?.content
        self.navigationTitleItem.title = recommend?.classification
        self.gobackButton.tintColor = .systemBlue
    }
    
    @IBAction private func didGoButtonTouchedUp(_ sender: UIButton) {
        if let websiteURL = recommend?.url,
           let url = URL(string: websiteURL) {
            let view: SFSafariViewController = SFSafariViewController(url: url)
            self.present(view, animated: true, completion: nil)
        }
    }
}
