//
//  Third_CollectionViewController.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 24.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation
import UIKit

class Third_CollectionViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var data : [MemeData] = [MemeData]()
    private let generator = DataGenerator()
    private var collectionView = UICollectionView(frame: CGRect.init(), collectionViewLayout: UICollectionViewFlowLayout())
    
    let cellID = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = generator.createData(amount: Int.random(in: 3...12))
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 200, height: 200)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.frame = self.view.frame
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1)
        self.view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        let currentLastItem = data[indexPath.row]
        cell.data = currentLastItem
        
        return cell
    }
    
}
