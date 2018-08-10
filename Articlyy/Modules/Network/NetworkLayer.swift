//
//  NetworkLayer.swift
//  Articlyy
//
//  Created by Kunal Verma on 08/08/18.
//  Copyright © 2018 Kunal Verma. All rights reserved.
//

import Foundation

class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    func getArticleData(with loader: Bool, success: @escaping (ArticleData) -> Void, failure: @escaping (Error) -> Void ) {
        if loader {
            CommonFunctions.showLoader()
        }
        _ = URLSession.shared.articleDataTask { (articleData, response, error) in
            DispatchQueue.main.async {
                if loader {
                    CommonFunctions.hideLoader()
                }
                if let articleData = articleData {
                    success(articleData)
                }
                else if let error = error {
                    failure(error)
                }
                else {
                    failure(MyError(msg: "Something happend! Try Again"))
                }
            }
        }.resume()
    }
}


public struct MyError: Error {
    let msg: String
    
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(msg, comment: "")
    }
}
