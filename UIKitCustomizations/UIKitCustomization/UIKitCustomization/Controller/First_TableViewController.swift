//
//  FirstViewController.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 19.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import UIKit

class First_TableViewController: UITableViewController {
    
    private var data : [MemeData] = [MemeData]()
    private let generator = DataGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1)
        
        data = generator.createData(amount: Int.random(in: 3...12))
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CustomTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! CustomTableViewCell
        let currentLastItem = data[indexPath.row]
        cell.data = currentLastItem
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.7)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
}


