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

extension RecommendationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recommendList.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.identifier, for: indexPath) as? RecommendCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let recommend = self.viewModel.recommendList.value?[indexPath.row] {
            cell.configureCell(with: recommend)
        }
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray.cgColor
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        
        let itemsPerRow: CGFloat = 1
        let widthPadding = 10 * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 5
        let heightPadding = 10 * (itemsPerRow + 1)
        
        let itemWidth = (width - widthPadding) / itemsPerRow
        let itemHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RecommendCollectionReusableView.identifier, for: indexPath) as? RecommendCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            return footer
        }
        return UICollectionReusableView()
    }
}
