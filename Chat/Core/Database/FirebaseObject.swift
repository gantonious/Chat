//
//  FirebaseObject.swift
//  Chat
//
//  Created by George Antonious on 2018-06-05.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import RxSwift
import FirebaseDatabase

protocol FirebaseObject {
    var id: String { get }
    static func getDataType() -> String
    init(from firebaseData: FirebaseData)
    func asFirebaseData() -> FirebaseData
}

struct FirebaseData {
    let id: String
    let rawData: [String: Any]
    
    init(id: String, rawData: [String: Any]) {
        self.id = id
        self.rawData = rawData
    }
}

extension DataSnapshot {
    func asFirebaseData() -> FirebaseData {
        return FirebaseData(id: self.key, rawData: self.value as! [String: Any])
    }
    
    func childrenAsFirebaseData() -> [FirebaseData] {
        return self.children
            .map { $0 as! DataSnapshot }
            .map { $0.asFirebaseData() }
    }
}

extension FirebaseObject {
    static func getReferenceToSelf() -> DatabaseReference {
        return DatabaseFactory.getReferenceTo(dataType: Self.getDataType())
    }
    
    static func getAll() -> Single<[Self]> {
        return getReferenceToSelf()
            .asReactiveReference()
            .observeSingleEvent(ofType: .value)
            .map { dataSnapshot in
                return dataSnapshot
                  .childrenAsFirebaseData()
                  .map { c in Self(from: c) }
            }
    }
    
    func update() -> Single<DatabaseReference> {
        return Self.getReferenceToSelf()
            .child(self.id)
            .asReactiveReference()
            .update(rawData: self.asFirebaseData().rawData)
    }

    static func observeAdditions() -> Observable<Self> {
        return getReferenceToSelf()
            .asReactiveReference()
            .observe(eventOfType: .childAdded)
            .map { Self(from: $0.asFirebaseData()) }
    }
}
