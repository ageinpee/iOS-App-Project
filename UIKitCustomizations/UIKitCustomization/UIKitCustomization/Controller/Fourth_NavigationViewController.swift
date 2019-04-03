//
//  Fourth_NavigationViewController.swift
//  UIKitCustomization
//
//  Created by Henrik Peters on 31.03.19.
//  Copyright © 2019 Henrik Peters. All rights reserved.
//

import UIKit

class Fourth_NavigationViewController: First_TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Use navigation controller to get to a new screen
        
        self.placeholderAlert(rowAt: indexPath)
    }
    
    private func placeholderAlert(rowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Placeholder Alert", message: "You selected row at \(indexPath.row)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
