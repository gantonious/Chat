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
    
    var loginSuccess: Observable<Content<User>> {
        return loginAttempts
            .asObservable()
            .filter { c in c != nil }
            .map { c in c!}
            .flatMap { c in
                Auth.reactiveAuth()
                    .signIn(withEmail: c.email, withPassword: c.password)
                    .map { r in User(email: r.user.email!) }
                    .wrapAsContent()
            }
    }
    
    func login(with credentials: LoginCredentials) {
        loginAttempts.onNext(credentials)
    }
}
