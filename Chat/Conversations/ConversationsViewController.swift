//
//  ConversationsViewController.swift
//  Chat
//
//  Created by George Antonious on 2018-06-01.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import UIKit
import RxSwift

class ConversationsViewController: UITableViewController {
    let conversationCellIdentifier = "CONVERSATION_CELL"
    let disposeBag = DisposeBag()
    
    var conversations = [Conversation]()
    
    static func createNavigationController() -> UIViewController {
        let navController = UINavigationController(rootViewController: ConversationsViewController())
        navController.navigationBar.prefersLargeTitles = true
//        navController.navigationBar.barTintColor = .from(hex: "#3A0078")
//        navController.navigationBar.tintColor = .white
//        navController.navigationBar.isTranslucent = false
//        navController.navigationBar.barStyle = .black
//        navController.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
//        navController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        

        return navController
    }
    
    override func viewDidLoad() {
        navigationItem.title = "Conversations"
        tableView.register(ConversationViewCell.self, forCellReuseIdentifier: conversationCellIdentifier)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl!
        
        ConversationService()
            .getConversations()
            .subscribe(onNext: { self.handleConversationContent(conversationContent: $0) })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("appeared")
    }
    
    @objc func didRefresh() {
        ConversationService()
            .getConversations()
            .subscribe(onNext: { self.handleConversationContent(conversationContent: $0) })
            .disposed(by: disposeBag)
    }
    
    func handleConversationContent(conversationContent: Content<[Conversation]>) {
        switch conversationContent {
            case .success(let conversations):
                print("good")
                updateConversations(conversations: conversations)
                refreshControl?.endRefreshing()
            case .error(let error):
                print(error)
                refreshControl?.endRefreshing()
            case .loading:
                print("loading")
        }
    }
    
    func updateConversations(conversations: [Conversation]) {
        self.conversations = conversations
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewCell = tableView.dequeueReusableCell(withIdentifier: conversationCellIdentifier, for: indexPath) as! ConversationViewCell
        viewCell.render(conversation: conversations[indexPath.row])
        return viewCell
    }
}
