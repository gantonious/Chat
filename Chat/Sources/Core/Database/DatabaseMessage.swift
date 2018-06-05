//
//  DatabaseMessage.swift
//  Chat
//
//  Created by George Antonious on 2018-06-05.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import Foundation

enum MessageType {
    case plainText(content: String)
}

struct DatabaseMessage {
    let id: String
    let fromId: String
    let conversationId: String
    let timestamp: Int
    let messageType: MessageType
}

extension DatabaseMessage: FirebaseObject {
    static func getDataType() -> String {
        return "messages"
    }
    
    init(from firebaseData: FirebaseData) {
        self.id = firebaseData.id
        self.fromId = firebaseData.rawData["fromId"] as! String
        self.conversationId = firebaseData.rawData["conversationId"] as! String
        self.timestamp = firebaseData.rawData["timestamp"] as! Int
        self.messageType = .plainText(content: "message")
    }
    
    func asRawData() -> [String : Any] {
        return [:]
    }
}
