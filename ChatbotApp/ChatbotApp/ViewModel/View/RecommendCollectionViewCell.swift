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
    @IBOutlet private var summaryLabel: UILabel!
    
    func configureCell(with recommend: Recommend) {
        classificationLabel.text = "[\(recommend.classification)]"
        classificationLabel.font = .preferredFont(forTextStyle: .headline)
        
        summaryLabel.font = .preferredFont(forTextStyle: .body)
        switch recommend.classification {
        case Classification.tour:
            classificationLabel.textColor = .systemOrange
            summaryLabel.text = "내용: \(recommend.summary)"
        case Classification.policy:
            classificationLabel.textColor = .systemRed
            summaryLabel.text = "\(recommend.summary)"
        case Classification.welfare:
            classificationLabel.textColor = .systemBlue
            summaryLabel.text = "\(recommend.summary)"
        default:
            classificationLabel.textColor = .black
            summaryLabel.text = "내용: \(recommend.summary)"
        }
        
        titleLabel.text = "제목: \(recommend.title)"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        classificationLabel.text = nil
        summaryLabel.text = nil
    }
}
