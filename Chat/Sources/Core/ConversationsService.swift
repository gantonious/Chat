//
//  ConversationsService.swift
//  Chat
//
//  Created by George Antonious on 2018-06-01.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseDatabase

struct Conversation {
    let name: String
    let participants: [String]
    let latestMessage: String
    
    func isGroupChat() -> Bool {
        return participants.count > 2
    }
    
    init(name: String, participants: [String], latestMessage: String) {
        self.name = name
        self.participants = participants
        self.latestMessage = latestMessage
    }
    
    init(fromDict: [String : Any]) {
        self.name = fromDict["conversationName"] as! String
        self.participants = fromDict["participants"] as! [String]
        self.latestMessage = ""
    }
    
    func dataType() -> String {
        return "conversations"
    }
    
    func toDict() -> [String : Any] {
        return [
            "conversationName" : self.name,
            "participants" : self.participants
        ]
    }
    
    
}

let fakeConversations = [
    Conversation(name: "David Skrundz", participants: ["g", "d"], latestMessage: "Hi im david")
]

class ConversationService {
    let conversationsReference = DatabaseFactory.getReferenceTo(dataType: "conversations")
    
    func getConversations() -> Observable<Content<[Conversation]>> {
        return Observable
            .just(fakeConversations)
            .delay(2, scheduler: MainScheduler.instance)
            .wrapAsContent()
    }
}
