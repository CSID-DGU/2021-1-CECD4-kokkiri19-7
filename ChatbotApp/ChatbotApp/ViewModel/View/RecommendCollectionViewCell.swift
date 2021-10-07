//
//  RecommendCollectionViewCell.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/07.
//

import UIKit

final class RecommendCollectionViewCell: UICollectionViewCell {
    private enum Classification {
        static let tour = "관광"
        static let policy = "정책"
        static let welfare = "복지"
    }
    
    static let identifier = "RecommendCollectionViewCell"
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var classificationLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!
    
    func configureCell(with recommend: Recommend) {
        classificationLabel.text = "[\(recommend.classification)]"
        switch recommend.classification {
        case Classification.tour:
            classificationLabel.textColor = .systemOrange
        case Classification.policy:
            classificationLabel.textColor = .systemRed
        case Classification.welfare:
            classificationLabel.textColor = .systemBlue
        default:
            classificationLabel.textColor = .black
        }
        
        titleLabel.text = "제목: \(recommend.title)"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        
        contentLabel.text = "내용: \(recommend.content)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        classificationLabel.text = nil
        contentLabel.text = nil
    }
}
