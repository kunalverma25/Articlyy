//
//  ArticleCollectionCell.swift
//  Articlyy
//
//  Created by Kunal Verma on 09/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import UIKit
import Kingfisher

class ArticleCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var bkgroundView: UIView!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var buttonDelegate: LikeDislikeDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bkgroundView.layer.cornerRadius = 10
        bkgroundView.layer.borderWidth = 2
        bkgroundView.layer.borderColor = UIColor.white.cgColor
        bkgroundView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        likeButton.isSelected = false
        dislikeButton.isSelected = false
        articleImage.image = UIImage(named: "home24")
        priceLabel.text = "Price : N/A"
    }
    
    func configureCell(with article: Article?) {
        if let media = article?.media, media.count > 0, let urlString = media[0].uri, let url = URL(string: urlString) {
            articleImage.kf.setImage(with: url, placeholder: UIImage(named: "home24"))
        }
        titleLabel.text = article?.title
        priceLabel.text = getArticlePrice(from: article?.price)
        setLikeDislikeButtons(article?.isLiked)
    }
    
    func getArticlePrice(from price: Price?) -> String {
        guard let price = price, let currency = price.currency, let amount = price.amount else { return "Price : N/A" }
        return "Price : \(currency) \(amount)"
    }
    
    func setLikeDislikeButtons(_ like: Bool?) {
        guard let like = like else { return }
        likeButton.isSelected = like
        dislikeButton.isSelected = !like
    }
    
    @IBAction func likeDislikePressed(_ sender: UIButton) {
        if sender.isSelected { return }
        sender.isSelected = true
        var like = true
        switch sender.tag {
        case 0:
            likeButton.isSelected = false
            like = false
        default:
            dislikeButton.isSelected = false
        }
        buttonDelegate?.didLikeDislike(for: self.tag, like: like)
    }

}


protocol LikeDislikeDelegate : class {
    func didLikeDislike(for cell: Int, like: Bool)
}
