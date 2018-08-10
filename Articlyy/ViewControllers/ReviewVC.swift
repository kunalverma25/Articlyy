//
//  ReviewVC.swift
//  Articlyy
//
//  Created by Kunal Verma on 09/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import UIKit

class ReviewVC: UIViewController {
    
    @IBOutlet weak var reviewCollection: UICollectionView!
    
    var gridLayout: GridLayout!
    var listLayout: ListLayout!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppConstants.pageReviewTitle
        self.reviewCollection.register(UINib(nibName:"ReviewCollectionCell", bundle: nil), forCellWithReuseIdentifier: CellIdentifiers.collectionReviewCell)
        gridLayout = GridLayout(numberOfColumns: 3)
        listLayout = ListLayout(itemHeight: 150)
        reviewCollection.collectionViewLayout = listLayout
        reviewCollection.delegate = self
        reviewCollection.dataSource = self
        reviewCollection.reloadData()
    }
    
    @IBAction func viewTypeChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.1, animations: {
                self.reviewCollection.collectionViewLayout.invalidateLayout()
                self.reviewCollection.setCollectionViewLayout(self.listLayout, animated: false)
            })
        }
        else {
            UIView.animate(withDuration: 0.1, animations: {
                self.reviewCollection.collectionViewLayout.invalidateLayout()
                self.reviewCollection.setCollectionViewLayout(self.gridLayout, animated: false)
            })
        }
    }
    
    
}

extension ReviewVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ArticlesViewModel.shared.articles!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.collectionReviewCell, for: indexPath) as! ReviewCollectionCell
        cell.configureCell(with: ArticlesViewModel.shared.articles?[indexPath.item])
        return cell
    }
    
}
