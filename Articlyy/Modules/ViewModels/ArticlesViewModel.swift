//
//  ArticlesViewModel.swift
//  Articlyy
//
//  Created by Kunal Verma on 08/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import Foundation

class ArticlesViewModel : NSObject {
    
    static let shared = ArticlesViewModel()
    
    var articles: [Article]?
    
    func getArticles(with loader: Bool, completion: @escaping ()->()) {
        NetworkLayer.shared.getArticleData(with: loader, success: { (articleData) in
            self.articles = articleData.embedded?.articles
            completion()
        }) { (error) in
            CommonFunctions.showToast(msg: error.localizedDescription)
        }
    }
    
    //MARK: Binding Methods
    func numberOfArticles() -> Int {
        guard let count = articles?.count else { return 0 }
        return count
    }
    
    func articleImageURL(for index: Int) -> URL? {
        guard let mediaCount = articles?[index].media?.count, mediaCount > 0, let uri = articles?[index].media?[0].uri, let url = URL(string: uri) else { return nil }
        return url
    }
    
    func articleTitle(for index: Int) -> String? {
        guard let title = articles?[index].title else { return nil }
        return title
    }
    
    func articlesLikedAndTotal() -> (Int, Int) {
        return (articles?.filter{ $0.isLiked == true }.count ?? 0, articles?.count ?? 0)
    }
    
    func likeUnlikeArticle(at index: Int, liked: Bool) {
        guard let count = articles?.count, count > index else { return }
        articles?[index].isLiked = liked
    }
    
    func allArticlesChecked() -> Bool {
        guard let count = articles?.count, count > 0 else { return false }
        return articles?.filter{ $0.isLiked != nil }.count == articles?.count
    }
    
    func nextOrFirstNonReviewedArticle(from index: Int) -> Int? {
        guard let count = articles?.count, count > 0 else { return nil }
        if index < count - 1 {
            for i in index..<count {
                if articles?[i].isLiked == nil {
                    return i
                }
            }
            for i in 0..<index {
                if articles?[i].isLiked == nil {
                    return i
                }
            }
        }
        else {
            for i in 0..<index {
                if articles?[i].isLiked == nil {
                    return i
                }
            }
        }
        return nil
    }
    
}
