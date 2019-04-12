//
//  CustomCollectionViewCell.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 28.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation
import UIKit

protocol CustomCollectionViewCellDelegate {
    func increment(cell: CustomCollectionViewCell)
}

class CustomCollectionViewCell: UICollectionViewCell {
    var data : MemeData? {
        didSet {
            titleLabel.text = data?.title
            placeholderImage.image = UIImage(named: (data?.imageName)!)
            descriptionLabel.text = data?.description
        }
    }
    
    private var amount = 0
    var delegate : CustomCollectionViewCellDelegate?
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "placeholder 1"
        label.textAlignment = .center
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let placeholderImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "placeholder")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor.darkGray.cgColor
        image.layer.cornerRadius = 3
        return image
    }()
    
    private let descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.text = "placeholder 2"
        label.minimumScaleFactor = 0.2
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let amountLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    private let incrementButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        return button
    }()
    
    @objc func increment(sender: UIButton!) {
        self.amount += 1
        self.amountLabel.text = String(amount)
        delegate?.increment(cell: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 0.7)
        
        addSubview(titleLabel)
        addSubview(placeholderImage)
        addSubview(descriptionLabel)
        insertSubview(incrementButton, aboveSubview: placeholderImage)
        insertSubview(amountLabel, aboveSubview: titleLabel)
        
        incrementButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        
        placeholderImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 30, paddingBottom: 5, paddingRight: 30, width: 100, height: 100, enableInsets: false, centerX: nil, centerY: nil)
        titleLabel.anchor(top: placeholderImage.bottomAnchor, left: leftAnchor, bottom: nil, right: leftAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 20, enableInsets: false, centerX: centerXAnchor, centerY: nil)
        amountLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 0, paddingRight: 5, width: 0, height: 0, enableInsets: false, centerX: nil, centerY: nil)
        descriptionLabel.anchor(top: amountLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 0, height: 50, enableInsets: false, centerX: nil, centerY: nil)
        incrementButton.anchor(top: placeholderImage.topAnchor, left: placeholderImage.leftAnchor, bottom: placeholderImage.bottomAnchor, right: placeholderImage.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, enableInsets: false, centerX: nil, centerY: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
}
