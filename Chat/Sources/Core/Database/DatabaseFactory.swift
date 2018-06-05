//
//  DatabaseFactory.swift
//  Chat
//
//  Created by George Antonious on 2018-06-05.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseFactory {
    static func getReferenceTo(dataType: String) -> DatabaseReference {
        return Database.database()
            .reference(fromURL: "https://chat-a6618.firebaseio.com/")
            .child(dataType)
    }
}
