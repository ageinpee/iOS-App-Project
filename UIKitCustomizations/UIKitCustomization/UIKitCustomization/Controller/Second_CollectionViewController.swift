//
//  SecondViewController.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 19.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//
import Foundation
import UIKit
import WikipediaKit

class Second_CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var data : [WikipediaArticle?] = [WikipediaArticle?]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private var collectionView = UICollectionView(frame: CGRect.init(), collectionViewLayout: UICollectionViewFlowLayout())
    
    let cellID = "Cell"
    
    private var language = WikipediaLanguage("en")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: 190, height: 300)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        self.prepareWikipediaAPI(language: WikipediaLanguage("en"))
        self.fetchMostRead(amount: 7)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.frame = self.view.frame
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WikipediaCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        self.view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WikipediaCollectionViewCell
        let currentLastItem = data[indexPath.row]
        cell.data = currentLastItem
        
        return cell
    }

    // MARK - Load Data from Wikipedia
    
    private var cachedMostReadArticlePreview = [WikipediaArticlePreview]()
    var articles = [WikipediaArticle]()
    
    func prepareWikipediaAPI(language: WikipediaLanguage) {
        WikipediaNetworking.appAuthorEmailForAPI = "henrik.peters.98@web.de"
        
        self.language = language
    }
    
//    func fetchMostReadPreview() {
//        var output = [WikipediaArticlePreview?]()
//        let yesterday = Date(timeIntervalSinceNow: -60*60*24)
//        let _ = Wikipedia.shared.requestMostReadArticles(language: language, date: yesterday, completion: { (articlePreviews, date, resultsLanguage, error) in
//            guard error == nil else { return }
//            guard let articlePreviews = articlePreviews else { return }
//
//            for a in articlePreviews {
//                output.append(a)
//            }
//            self.data = output
//            DispatchQueue.main.async(execute: {self.collectionView.reloadData()})
//        })
//    }
    
//    func fetchMostReadPreview(amount: Int) {
//        var output = [WikipediaArticlePreview?]()
//        let yesterday = Date(timeIntervalSinceNow: -60*60*24)
//        let _ = Wikipedia.shared.requestMostReadArticles(language: language, date: yesterday, completion: { (articlePreviews, date, resultsLanguage, error) in
//            guard error == nil else { return }
//            guard let articlePreviews = articlePreviews else { return }
//            
//            for a in articlePreviews {
//                output.append(a)
//            }
//            self.data = Array(output.prefix(amount))
//            DispatchQueue.main.async(execute: {self.collectionView.reloadData()})
//        })
//    }
    
    func fetchMostRead(amount: Int) {
        self.data = [WikipediaArticle?]()
        let yesterday = Date(timeIntervalSinceNow: -60*60*24)
        let _ = Wikipedia.shared.requestMostReadArticles(language: self.language, date: yesterday, completion: { (articlePreviews, date, resultsLanguage, error) in
            guard error == nil else { self.showLoadingErrorAlert(); return }
            guard let articlePreviews = articlePreviews else { return }
            
            let articlePreviewsFirstX = Array(articlePreviews.prefix(amount))
            for a in articlePreviewsFirstX {
                let imageWidth = 500
                let _ = Wikipedia.shared.requestArticle(language: self.language, title: a.displayTitle, imageWidth: imageWidth, completion: { (article, error) in
                    guard error == nil else { return }
                    guard let article = article else { return }
                    
                    let temp = self.data + [article]
                    self.data = temp
                    DispatchQueue.main.async(execute: { print("dispatch executed"); self.collectionView.reloadData()})
                })
            }
        })
    }
    
    private func showLoadingErrorAlert() {
        let alert = UIAlertController(title: "Network-Error", message: "Something went wrong while loading data", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: { (alertAction) in
            self.fetchMostRead(amount: 7)
        }))
        self.present(alert, animated: true)
    }
    
}
