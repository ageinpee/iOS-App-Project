//
//  FirstViewController.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 19.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import UIKit

class First_TableViewController: UITableViewController {
    
    private var data : [TableViewData] = [TableViewData]()
//    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        data = createData(amount: Int.random(in: 3...12))
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
        return cell
    }
    
    
    private func createData(amount: Int) -> [TableViewData] {
        let titleList = ["Title 1", "Title 2", "Title 3", "Title 4", "Title 5", "Title 6"]
        let descriptitonList = ["Description 1", "Description 2", "Description 3", "Description 4", "Description 5", "Description 6"]
        var output = [TableViewData]()
        
        for _ in 0..<amount {
            output.append(TableViewData(with: titleList.randomElement() ?? "Error", with: "placeholder", with: descriptitonList.randomElement() ?? "Error"))
        }
        return output
    }
}


