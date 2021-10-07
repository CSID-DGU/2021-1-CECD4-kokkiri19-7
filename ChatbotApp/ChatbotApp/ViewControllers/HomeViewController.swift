//
//  ViewController.swift
//  ChatbotApp
//
//  Created by Yeon on 2021/05/10.
//

import UIKit
import SafariServices

final class HomeViewController: UIViewController {
    @IBOutlet private weak var nicknameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var characterImageView: UIImageView!
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.hidesForSinglePage = true
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        return pageControl
    }()
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        configureImageCollectionView()
        configurePageControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //viewModel.fetch()
        viewModel.test()
    }
    
    private func configureImageCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BannerImageCollectionViewCell.self, forCellWithReuseIdentifier: BannerImageCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.isScrollEnabled = true
        collectionView.bounces = false
    }
    
    private func configurePageControl() {
        self.view.addSubview(pageControl)
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: self.collectionView.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: self.collectionView.safeAreaLayoutGuide.topAnchor, constant: 280)
        ])
    }
    
    private func bindView() {
        viewModel.nicknameLabelText.bind({ [weak self] text in
            DispatchQueue.main.async {
                self?.nicknameLabel.text = text
            }
        })
        
        viewModel.locationLabelText.bind({ [weak self] text in
            DispatchQueue.main.async {
                self?.locationLabel.text = text
            }
        })
        
        viewModel.characterImage.bind { [weak self] image in
            DispatchQueue.main.async {
                self?.characterImageView.image = image
            }
        }
        
        viewModel.bannerImages.bind({ [weak self] images in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
                self?.pageControl.numberOfPages = images?.count ?? 0
            }
        })
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.bannerImages.value?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerImageCollectionViewCell.identifier, for: indexPath) as? BannerImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let image = self.viewModel.bannerImages.value?[indexPath.row] {
            cell.configure(image: image)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: viewModel.urls.value?[indexPath.row] ?? "") {
            let view: SFSafariViewController = SFSafariViewController(url: url)
            self.present(view, animated: true, completion: nil)
        }
    }
}
