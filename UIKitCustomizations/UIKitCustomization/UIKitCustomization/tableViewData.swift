//
//  tableViewData.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 22.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation

struct TableViewData {
    var title = ""
    var imageName = "placeholder"
    var description = ""
    
    init(with title: String, with imageName: String, with description: String) {
        self.title = title
        self.imageName = imageName
        self.description = description
    }
}
