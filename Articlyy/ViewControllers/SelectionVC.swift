//
//  SelectionVC.swift
//  Articlyy
//
//  Created by Kunal Verma on 09/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import UIKit

class SelectionVC: UIViewController {
    
    @IBOutlet private weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var articlesCollection: UICollectionView!
    @IBOutlet weak var likedCountButton: GradientButton!
    @IBOutlet weak var reviewButton: GradientButton!
    
    private var indexOfCellBeforeDragging = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppConstants.pageArticleTitle
        self.articlesCollection.register(UINib(nibName:"ArticleCollectionCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.collectionArticleCell)
        collectionViewLayout.minimumLineSpacing = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if ArticlesViewModel.shared.articles == nil || ArticlesViewModel.shared.articles?.count == 0 {
            ArticlesViewModel.shared.getArticles(with: true) {
                self.loadArticles()
            }
        }
        else {
            self.loadArticles()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCollectionViewLayoutItemSize()
    }
    
    func loadArticles(_ index: Int = 0) {
        self.articlesCollection.delegate = self
        self.articlesCollection.dataSource = self
        self.articlesCollection.reloadData()
        updateLikeReview(index)
    }
    
    func updateLikeReview(_ index: Int) {
        let likeCount = ArticlesViewModel.shared.articlesLikedAndTotal()
        let likeText = "Liked : \(likeCount.0)/\(likeCount.1)"
        reviewButton.isEnabled = ArticlesViewModel.shared.allArticlesChecked()
        likedCountButton.setTitle(likeText, for: .normal)
        if let unread = ArticlesViewModel.shared.nextOrFirstNonReviewedArticle(from: index) {
            articlesCollection.scrollToItem(at: IndexPath(item: unread, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension SelectionVC: UICollectionViewDataSource, UICollectionViewDelegate, LikeDislikeDelegate {
    
    func calculateSectionInset() -> CGFloat {
        let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
        let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
        let cellBodyWidth: CGFloat = 236 + (cellBodyViewIsExpended ? 174 : 0)
        let buttonWidth: CGFloat = 50
        let inset = (collectionViewLayout.collectionView!.frame.width - cellBodyWidth + buttonWidth) / 4
        return inset
    }
    
    func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset()
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        collectionViewLayout.itemSize = CGSize(width: collectionViewLayout.collectionView!.frame.size.width - inset * 2, height: collectionViewLayout.collectionView!.frame.size.height - 30)
    }
    
    func indexOfMajorCell() -> Int {
        let itemWidth = collectionViewLayout.itemSize.width
        let proportionalOffset = collectionViewLayout.collectionView!.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(ArticlesViewModel.shared.articles!.count - 1, index))
        return safeIndex
    }
    
    // MARK: - UICollectionViewDataSource:
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArticlesViewModel.shared.articles!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.collectionArticleCell, for: indexPath) as! ArticleCollectionCell
        cell.configureCell(with: ArticlesViewModel.shared.articles?[indexPath.item])
        cell.tag = indexPath.item
        cell.buttonDelegate = self
        return cell
    }
    
    // MARK: - UICollectionViewDelegate:
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let indexOfMajorCell = self.indexOfMajorCell()
        
        let swipeVelocityThreshold: CGFloat = 0.5
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < ArticlesViewModel.shared.articles!.count && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)
        
        if didUseSwipeToSkipCell {
            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collectionViewLayout.itemSize.width * CGFloat(snapToIndex)
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collectionViewLayout.collectionView!.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    
    
    func didLikeDislike(for cell: Int, like: Bool) {
        ArticlesViewModel.shared.likeUnlikeArticle(at: cell, liked: like)
        self.articlesCollection.reloadItems(at: [IndexPath(item: cell, section: 0)])
        updateLikeReview(cell)
    }
}
