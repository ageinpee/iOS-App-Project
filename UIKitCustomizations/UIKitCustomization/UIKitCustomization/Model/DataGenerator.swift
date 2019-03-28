//
//  DataGenerator.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 28.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import Foundation

class DataGenerator {
    func createData(amount: Int) -> [MemeData] {
        let titleList = ["Memes and How they started", "All about that Memes", "Take me to the Memes", "Memecity", "Backstreet Memes", "Meme it like it's hot"]
        let descriptitonList = ["Creating Memes has always been a hard job. Here's a guide on how to do it",
                                "What is more satifying than looking at Memes all day? Nothing? We'll Sir you are right!",
                                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.",
                                "You want a description? Memes don't need that",
                                "No more Memes with Article 13!",
                                "Memes4Memes is the best Memetrader in the World Wide Web. Check out now!"]
        let imageNames = ["meme1", "meme2", "meme3", "meme4", "meme5", "meme6"]
        var output = [MemeData]()
        
        for _ in 0..<amount {
            output.append(MemeData(with: titleList.randomElement() ?? "Error", with: imageNames.randomElement() ?? "meme1", with: descriptitonList.randomElement() ?? "Error"))
        }
        return output
    }
}
