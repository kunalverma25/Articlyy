//
//  ReviewCollectionCell.swift
//  Articlyy
//
//  Created by Kunal Verma on 10/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import UIKit

class ReviewCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        articleImage.image = UIImage(named: "home24")
        titleLabel.text = nil
        priceLabel.text = nil
        likeImage.image = nil
    }
    
    func configureCell(with article: Article?) {
        if let media = article?.media, media.count > 0, let urlString = media[0].uri, let url = URL(string: urlString) {
            articleImage.kf.setImage(with: url, placeholder: UIImage(named: "home24"))
        }
        titleLabel.text = article?.title
        priceLabel.text = getArticlePrice(from: article?.price)
        if article?.isLiked == true {
            likeImage.image = UIImage(named: "likeFull")
        }
        else {
            likeImage.image = nil
        }
    }
    
    func getArticlePrice(from price: Price?) -> String {
        guard let price = price, let currency = price.currency, let amount = price.amount else { return "Price : N/A" }
        return "Price : \(currency) \(amount)"
    }

}
