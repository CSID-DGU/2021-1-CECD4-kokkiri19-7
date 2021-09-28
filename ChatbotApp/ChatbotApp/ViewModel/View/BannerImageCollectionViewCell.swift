//
//  BannerImageCollectionViewCell.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/09/19.
//

import UIKit

final class BannerImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "BannerImageCollectionViewCell"
    private var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureView() {
        self.contentView.addSubview(bannerImageView)
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bannerImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            bannerImageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    func configure(image: UIImage) {
        self.bannerImageView.image = image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bannerImageView.image = nil
    }
}
