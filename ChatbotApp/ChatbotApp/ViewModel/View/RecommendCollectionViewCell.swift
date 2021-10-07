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

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var classificationLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!
}
