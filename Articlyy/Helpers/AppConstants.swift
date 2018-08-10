//
//  AppConstants.swift
//  Articlyy
//
//  Created by Kunal Verma on 08/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

struct AppConstants {
    // Fetch from firebase remote config for flexibility
    static let articleValue: Int = 10
    static let baseURL: String = "https://api-mobile.home24.com/api/v1/"
    
    //Page Titles
    static let pageArticleTitle: String = "Your Articles"
    static let pageReviewTitle: String = "Review Likes"
}

struct CellIdentifiers {
    
    static let collectionArticleCell: String = "collectionArticleCell"
    static let collectionReviewCell: String = "collectionReviewCell"
}
