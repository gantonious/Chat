//
//  ConversationsService.swift
//  Chat
//
//  Created by George Antonious on 2018-06-01.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import Foundation
import RxSwift

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
}

let fakeConversations = [
    Conversation(name: "David Skrundz", participants: ["g", "d"], latestMessage: "Hi im david")
]

class ConversationService {
    func getConversations() -> Observable<Content<[Conversation]>> {
        return Observable
            .just(fakeConversations)
            .wrapAsContent()
    }
}
