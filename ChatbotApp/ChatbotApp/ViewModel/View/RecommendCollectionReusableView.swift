//
//  RecommendCollectionReusableView.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/07.
//

import UIKit

final class RecommendCollectionReusableView: UICollectionReusableView {
    static let identifier = "RecommendCollectionReusableView"
    private var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .systemGray
        indicator.style = .medium
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureFooterView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureFooterView()
    }
}
