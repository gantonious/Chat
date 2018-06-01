//
//  FirebaseAuth+rx.swift
//  Chat
//
//  Created by George Antonious on 2018-06-01.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import FirebaseAuth
import RxSwift

public extension Auth {
    public static func reactiveAuth() -> FirebaseAuthRxExtensions {
        return FirebaseAuthRxExtensions(auth: Auth.auth())
    }
}

public class FirebaseAuthRxExtensions {
    let auth: Auth
    
    public init(auth: Auth) {
        self.auth = auth
    }
    
    public func signIn(withEmail email: String, withPassword password: String) -> Observable<AuthDataResult> {
        return Observable.create { observer in
            self.auth.signIn(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    observer.onError(error)
                } else if let user = user {
                    observer.onNext(user)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
    
    public func createUser(withEmail email: String, withPassword password: String) -> Observable<AuthDataResult> {
        return Observable.create { observer in
            self.auth.createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    observer.onError(error)
                } else if let user = user {
                    observer.onNext(user)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
}
