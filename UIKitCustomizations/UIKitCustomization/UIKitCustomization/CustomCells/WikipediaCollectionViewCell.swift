//
//  WikipediaCollectionViewCell.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 28.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation
import UIKit
import WikipediaKit

protocol WikipediaCollectionViewCellDelegate {
    func increment(cell: WikipediaCollectionViewCell)
}

class WikipediaCollectionViewCell: UICollectionViewCell {
    var data : WikipediaArticle? {
        didSet {
            titleLabel.text = data?.displayTitle.htmlToString
            textLabel.text = data?.displayText.htmlToString
        }
    }
    
    private var amount = 0
    var delegate : WikipediaCollectionViewCellDelegate?
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "placeholder 1"
        label.textAlignment = .center
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let textLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .left
        label.text = "placeholder 2"
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 0.7)
        self.layer.cornerRadius = 5
        
        addSubview(titleLabel)
        addSubview(textLabel)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false, centerX: centerXAnchor, centerY: nil)
        textLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 0, enableInsets: false, centerX: centerXAnchor, centerY: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
