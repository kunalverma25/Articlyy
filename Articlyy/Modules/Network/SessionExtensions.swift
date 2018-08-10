//
//  SessionExtensions.swift
//  Articlyy
//
//  Created by Kunal Verma on 08/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import Foundation

extension URLSession {
    
    //Generic Data Task for fetching Data
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    //Data Task for ArticleData
    func articleDataTask(with completionHandler: @escaping (ArticleData?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let url = ServiceEndpoints.article.getArticleUrlWithArticles(AppConstants.articleValue)
        return self.codableTask(with: url!, completionHandler: completionHandler)
    }
}
