//
//  CustomTableViewCell.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 22.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    var data : TableViewData? {
        didSet {
            titleLabel.text = data?.title
            placeholderImage.image = UIImage(named: (data?.imageName)!)
            descriptionLabel.text = data?.description
        }
    }
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "placeholder 1"
        return label
    }()
    
    private let placeholderImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.text = "placeholder 2"
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(placeholderImage)
        addSubview(descriptionLabel)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: frame.size.width/3, height: 100, enableInsets: false)
        placeholderImage.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: frame.size.width/3, height: 200, enableInsets: false)
        descriptionLabel.anchor(top: topAnchor, left: placeholderImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: frame.size.width/3, height: 200, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
