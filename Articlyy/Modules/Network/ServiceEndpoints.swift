//
//  ServiceEndpoints.swift
//  Articlyy
//
//  Created by Kunal Verma on 08/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import Foundation

enum ServiceEndpoints: String {
    
    case article = "articles?appDomain=1&locale=de_DE"
    case other = ""
    
    func getArticleUrlWithArticles(_ number: Int? ) -> URL? {
        var articleURLString = AppConstants.baseURL + self.rawValue
        if let number = number, number > 0 {
            switch self {
            case .article :
                articleURLString += "&limit=\(number)"
            default :
                break
            }
        }
        
        guard let url = URL(string: articleURLString) else { return nil }
        return url
    }
    
}


