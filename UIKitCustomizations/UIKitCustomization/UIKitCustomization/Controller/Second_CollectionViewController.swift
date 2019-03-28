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

    private var data : [WikipediaArticlePreview] = [WikipediaArticlePreview]()
    private var collectionView = UICollectionView(frame: CGRect.init(), collectionViewLayout: UICollectionViewFlowLayout())
    
    let cellID = "Cell"
    let wikiData = WikipediaData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.itemSize = CGSize(width: 125, height: 125)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        data = wikiData.loadMostPopular(amount: 20)
        
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


}

