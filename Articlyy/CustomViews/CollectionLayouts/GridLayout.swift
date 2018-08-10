//
//  GridLayout.swift
//  Articlyy
//
//  Created by Kunal Verma on 10/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {
    
    var numberOfColumns: Int = 3
    
    init(numberOfColumns: Int) {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        
        self.numberOfColumns = numberOfColumns
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var itemSize: CGSize {
        get {
            if let collectionView = collectionView {
                let itemWidth: CGFloat = (collectionView.frame.width/CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing
                return CGSize(width: itemWidth, height: itemWidth)
            }
            
            // Default fallback
            return CGSize(width: 100, height: 100)
        }
        set {
            super.itemSize = newValue
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return proposedContentOffset
    }
    
}
