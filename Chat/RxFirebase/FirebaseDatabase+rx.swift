//
//  FirebaseDatabse+rx.swift
//  Chat
//
//  Created by George Antonious on 2018-06-03.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import RxSwift
import FirebaseDatabase

extension DatabaseReference {
    func asReactiveReference() -> FirebaseDatabaseRxExtensions {
        return FirebaseDatabaseRxExtensions(databaseReference: self)
    }
}

public class FirebaseDatabaseRxExtensions {
    private let databaseReference: DatabaseReference
    
    init(databaseReference: DatabaseReference) {
        self.databaseReference = databaseReference
    }
    
    public func observe(eventOfType: DataEventType) -> Observable<DataSnapshot> {
        return Observable.create { observer in
            let handle = self.databaseReference.observe(eventOfType) { dataSnapshot in
                observer.onNext(dataSnapshot)
            }
            
            return Disposables.create {
                self.databaseReference.removeObserver(withHandle: handle)
            }
        }
    }
    
    public func observeSingleEvent(ofType event: DataEventType) -> Single<DataSnapshot> {
        return Observable.create { observer in
            self.databaseReference.observeSingleEvent(of: event) { dataSnapshot in
                observer.onNext(dataSnapshot)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
        .asSingle()
    }
    
    public func update(rawData: [String: Any]) -> Single<DatabaseReference> {
        return Single.create { observer in
            self.databaseReference.updateChildValues(rawData) { (error, databaseReference) in
                if let updateError = error {
                    observer(.error(updateError))
                } else {
                    observer(.success(databaseReference))
                }
            }
            return Disposables.create()
        }

    }
//    public func observeAsList<T: FirebaseLoadable>() -> Observable<[T]> {
//        return self.observe(eventOfType: .value)
//            .map { dataSnapshot in
//                return dataSnapshot
//                    .children
//                    .flatMap { $0 as? [String:Any] ?? [:] }
//                    .map { d in T(fromDict: d) }
//            }
//    }
}
