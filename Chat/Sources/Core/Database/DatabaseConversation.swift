//
//  DatabaseConversation.swift
//  Chat
//
//  Created by George Antonious on 2018-06-05.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import Foundation

struct DatabaseConversation {
    let id: String
    let participants: [String]
    
    init(with id: String, from dictionary: [String: AnyObject]) {
        self.id = id
        self.participants = dictionary["participants"] as! [String]
    }
    
    func getId() -> String {
        return id
    }
    
    func asDict() -> [String: AnyObject] {
        return [
            "participants": participants as AnyObject
        ]
    }
}
