//
//  RecommendCollectionViewCell.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/10/07.
//

import UIKit

final class RecommendCollectionViewCell: UICollectionViewCell {
    private enum Classification {
        static let festival = "행사·축제"
        static let concert = "공연·전시"
        static let pregnant = "임신·출산"
        static let youth = "청년"
        static let child = "영유아"
        static let kid = "아동·청소년"
        static let mature = "중장년"
        static let old = "어르신"
        static let disabled = "장애인"
        static let all = "전생애주기"
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
        case Classification.all, Classification.child, Classification.disabled, Classification.kid, Classification.mature, Classification.youth, Classification.pregnant, Classification.old:
            classificationLabel.textColor = .systemOrange
            summaryLabel.text = "내용: \(recommend.summary)"
        case Classification.festival, Classification.concert:
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
