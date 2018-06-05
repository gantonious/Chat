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
