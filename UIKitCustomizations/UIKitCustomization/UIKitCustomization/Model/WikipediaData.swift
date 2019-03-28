//
//  WikipediaData.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 28.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation
import WikipediaKit

class WikipediaData {
    var articles = [WikipediaArticlePreview]()
    
    init() {
        WikipediaNetworking.appAuthorEmailForAPI = "henrik.peters.98@web.de"
        
        let language = WikipediaLanguage("en")
        let yesterday = Date(timeIntervalSinceNow: -60*60*24)
        let _ = Wikipedia.shared.requestMostReadArticles(language: language, date: yesterday, completion: { (articlePreviews, date, resultsLanguage, error) in
            
            print("before return <<<<<<<<<<<<<<")
            guard error == nil else { return }
            guard let articlePreviews = articlePreviews else { return }
            
            for a in articlePreviews {
                print(a.displayTitle)
                self.articles.append(a)
            }
        })
    }
    
    func loadMostPopular(amount: Int) -> [WikipediaArticlePreview] {
        return Array(articles.prefix(amount))
    }
}
