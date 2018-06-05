//
//  DatabaseUser.swift
//  Chat
//
//  Created by George Antonious on 2018-06-05.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import Foundation

struct DatabaseUser {
    let id: String
    let email: String
    
    init(email: String) {
        self.id = UUID.init().uuidString
        self.email = email
    }
}

extension DatabaseUser: FirebaseObject {
    static func getDataType() -> String {
        return "users"
    }
    
    init(from firebaseData: FirebaseData) {
        self.id = firebaseData.id
        self.email = firebaseData.rawData["email"] as? String ?? ""
    }
    
    func asFirebaseData() -> FirebaseData {
        let rawData = [
            "email": self.email
        ]
        
        return FirebaseData(id: self.id, rawData: rawData)
    }
}
