//
//  ConversationsViewController.swift
//  Chat
//
//  Created by George Antonious on 2018-06-01.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import UIKit

class ConversationsViewController: UITableViewController {
    static func createNavigationController() -> UINavigationController {
        return UINavigationController(rootViewController: ConversationsViewController())
    }
}
