//
//  LoginViewModel.swift
//  Chat
//
//  Created by George Antonious on 2018-06-01.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth

struct LoginCredentials {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

struct User {
    let email: String
    
    init(email: String) {
        self.email = email
    }
}

enum Content<T> {
    case success(T)
    case error(Error)
    case loading
}

extension Observable  {
    func wrapAsContent() -> Observable<Content<E>> {
        return self
            .map { e in Content.success(e) }
            .startWith(Content.loading)
            .catchError { e in .just(Content.error(e)) }
    }
}

class LoginViewModel {
    private let loginAttempts = BehaviorSubject<LoginCredentials?>(value: nil)
    
    var loginStatus: Observable<Content<User>> {
        return loginAttempts
            .asObservable()
            .flatMapLatest { c in self.authenticate(with: c) }
    }
    
    func authenticate(with creds: LoginCredentials?) -> Observable<Content<User>> {
        if let currUser = Auth.auth().currentUser {
            return Observable
                .just(User(email: currUser.email!))
                .wrapAsContent()
        }
        
        if let creds = creds {
            return Auth.reactiveAuth()
                .signIn(withEmail: creds.email, withPassword: creds.password)
                .map { r in User(email: r.user.email!) }
                .wrapAsContent()
        }
        
        return Observable.empty()
    }
    
    func login(with credentials: LoginCredentials) {
        loginAttempts.onNext(credentials)
    }
}
