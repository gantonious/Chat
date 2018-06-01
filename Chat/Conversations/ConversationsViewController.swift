//
//  ConversationsViewController.swift
//  Chat
//
//  Created by George Antonious on 2018-06-01.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import UIKit

class ConversationsViewController: UITableViewController {
    
    static func createNavigationController() -> UIViewController {
        let navController = UINavigationController(rootViewController: ConversationsViewController())
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Conversations"
    }
    
    
}
