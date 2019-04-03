//
//  CustomTableViewCell.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 22.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation
import UIKit

protocol CustomTableViewCellDelegate {
    func increment(cell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {
    var data : MemeData? {
        didSet {
            titleLabel.text = data?.title
            placeholderImage.image = UIImage(named: (data?.imageName)!)
            descriptionLabel.text = data?.description
        }
    }
    
    private var amount = 0
    var delegate : CustomTableViewCellDelegate?
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "placeholder 1"
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
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
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
        label.textAlignment = .right
        label.text = "0"
        return label
    }()
    
    private let incrementButton : UIButton = {
        let button = UIButton()
        button.setTitle("Increment", for: .normal)
        button.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    // TODO - add the functions to the button so the button is actually working
    @objc func increment(sender: UIButton!) {
        self.amount += 1
        self.amountLabel.text = String(amount)
        delegate?.increment(cell: self)
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // TODO - get the correct background color and opacity
        self.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 0.7)
//        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        addSubview(titleLabel)
        addSubview(placeholderImage)
        addSubview(descriptionLabel)
        addSubview(incrementButton)
        addSubview(amountLabel)
        
        incrementButton.addTarget(self, action: #selector(increment), for: .touchUpInside)
        
        titleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 5, paddingRight: 5, width: 0, height: 100, enableInsets: false, centerX: nil, centerY: nil)
        placeholderImage.anchor(top: topAnchor, left: titleLabel.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5, width: 150, height: 150, enableInsets: false, centerX: centerXAnchor, centerY: nil)
        descriptionLabel.anchor(top: topAnchor, left: placeholderImage.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 20, width: 0, height: 100, enableInsets: false, centerX: nil, centerY: nil)
        incrementButton.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: placeholderImage.leftAnchor, paddingTop: 15, paddingLeft: 20, paddingBottom: 5, paddingRight: 15, width: 0, height: 50, enableInsets: false, centerX: nil, centerY: nil)
        amountLabel.anchor(top: descriptionLabel.bottomAnchor, left: placeholderImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 20, width: 0, height: 50, enableInsets: false, centerX: nil, centerY: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
}
