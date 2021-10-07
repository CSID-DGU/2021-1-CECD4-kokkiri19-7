//
//  RecommendationViewController.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/06/01.
//

import UIKit

protocol DetailViewConfigurable: AnyObject {
    func configure(_ data: Recommend)
}

final class RecommendationViewController: UIViewController {
    private enum LoadingIndicatorState {
        case start
        case stop
    }
    
    static let identifier = "RecommendationViewController"
    private var viewModel = RecommendListViewModel()
    weak var detailViewConfigurableDelegate: DetailViewConfigurable?
    
    private var navigationBar: UINavigationBar = {
        let navigationbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        navigationbar.translatesAutoresizingMaskIntoConstraints = false
        return navigationbar
    }()
    
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
        configureRecommendationListView()
        bindViewModel()
    }
    
    private func configureRecommendationListView() {
        let navigationItem = UINavigationItem(title: "삼식이의 추천")
        navigationBar.setItems([navigationItem], animated: false)
        view.addSubview(navigationBar)
        
        view.addSubview(recommendCollectionView)
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            recommendCollectionView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 10),
            recommendCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recommendCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            recommendCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK:- bindViewModel
    private func bindViewModel() {
        viewModel.recommendList.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.recommendCollectionView.reloadData()
            }
        }
    }
}
