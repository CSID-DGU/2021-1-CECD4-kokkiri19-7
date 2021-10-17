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
    @IBOutlet private weak var recommendImageView: UIImageView!
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
        
        if let imageURL = recommend?.image {
            self.recommendImageView.isHidden = false
            let imageAPIRequest = GetImageAPIRequest()
            let apiRequestLoader = APIRequestLoader(apiReqeust: imageAPIRequest)
            
            apiRequestLoader.loadAPIReqeust(requestData: imageURL) { [weak self] image, error in
                if let image = image {
                    DispatchQueue.main.async {
                        self?.recommendImageView.image = image
                    }
                }
            }
        }
    }
    
    @IBAction private func didGoButtonTouchedUp(_ sender: UIButton) {
        if let websiteURL = recommend?.url,
           let url = URL(string: websiteURL) {
            let view: SFSafariViewController = SFSafariViewController(url: url)
            self.present(view, animated: true, completion: nil)
        }
    }
    
    @IBAction private func didGoBackButtonTouchedUp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RecommendDetailViewController: DetailViewConfigurable {
    func configure(_ data: Recommend) {
        self.recommend = data
    }
}
