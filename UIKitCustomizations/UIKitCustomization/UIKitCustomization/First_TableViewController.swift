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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 0.16, green: 0.16, blue: 0.16, alpha: 1)
        
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
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.7)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    private func createData(amount: Int) -> [TableViewData] {
        let titleList = ["Memes and How they started", "All about that Memes", "Take me to the Memes", "Memecity", "Backstreet Memes", "Meme it like it's hot"]
        let descriptitonList = ["Creating Memes has always been a hard job. Here's a guide on how to do it",
                                "What is more satifying than looking at Memes all day? Nothing? We'll Sir you are right!",
                                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.",
                                "You want a description? Memes don't need that",
                                "No more Memes with Article 13!",
                                "Memes4Memes is the best Memetrader in the World Wide Web. Check out now!"]
        let imageNames = ["meme1", "meme2", "meme3", "meme4", "meme5", "meme6"]
        var output = [TableViewData]()
        
        for _ in 0..<amount {
            output.append(TableViewData(with: titleList.randomElement() ?? "Error", with: imageNames.randomElement() ?? "meme1", with: descriptitonList.randomElement() ?? "Error"))
        }
        return output
    }
}


