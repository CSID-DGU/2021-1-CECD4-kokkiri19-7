//
//  RecommendationViewController.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/06/01.
//

import UIKit

final class RecommendationViewController: UIViewController {
    private enum LoadingIndicatorState {
        case start
        case stop
    }
    
    static let identifier = "RecommendationViewController"
    private var viewModel = RecommendListViewModel()

    private var recommendCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let nib = UINib(nibName: RecommendCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: RecommendCollectionViewCell.identifier)
        collectionView.register(RecommendCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: RecommendCollectionReusableView.identifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
