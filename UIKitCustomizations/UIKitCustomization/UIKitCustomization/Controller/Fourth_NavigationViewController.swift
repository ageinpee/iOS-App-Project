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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.placeholderAlert(rowAt: indexPath)
    }
    
    private func placeholderAlert(rowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Placeholder Alert", message: "You selected row at \(indexPath.row)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
