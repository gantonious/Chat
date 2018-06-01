//
//  LoginViewController.swift
//  Chat
//
//  Created by George Antonious on 2018-05-30.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import UIKit
import RxSwift
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let loginViewModel = LoginViewModel()
    
    let chatLogoImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ChatLogo")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let chatLabel: UILabel = {
        let label = UILabel()
        label.text = "Chat"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 40, weight: .ultraLight)
        return label
    }()
    
    let emailTextView: UITextField = {
        let textView = UITextField()
        textView.autocapitalizationType = .none
        textView.borderStyle = .roundedRect
        textView.placeholder = "Email"
        return textView
    }()
    
    let passwordTextView: UITextField = {
        let textView = UITextField()
        textView.autocapitalizationType = .none
        textView.borderStyle = .roundedRect
        textView.isSecureTextEntry = true
        textView.placeholder = "Password"
        return textView
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(didClickLoginButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didClickLoginButton() {
        loginViewModel.login(with: LoginCredentials(email: emailTextView.text!, password: passwordTextView.text!))
    }
    
    override func viewDidLoad() {
        buildViews()
        
        loginViewModel.loginSuccess
            .subscribe(onNext: { self.handleLoginResult(loginResult: $0) })
            .disposed(by: disposeBag)
    }
    
    private func handleLoginResult(loginResult: Content<User>) {
        switch(loginResult) {
            case .success(let user):
                print(user)
            case .error(let error):
                print(error)
            case .loading:
                print("🔄 loading")
        }
    }
}

extension LoginViewController {
    private func buildViews() {
        let safeBounds = view.safeAreaLayoutGuide
        
        view.backgroundColor = .from(hex: "#A25AFF")
        view.addSubview(chatLogoImageview)
        view.addSubview(chatLabel)
        view.addSubview(emailTextView)
        view.addSubview(passwordTextView)
        view.addSubview(loginButton)
        
        chatLogoImageview
            .alignCenterX(to: safeBounds.centerXAnchor)
            .with(height: 200)
            .anchorTop(to: safeBounds.topAnchor, withConstant: 100)
            .done()
        
        chatLabel
            .alignCenterX(to: safeBounds.centerXAnchor)
            .anchorTop(to: chatLogoImageview.bottomAnchor, withConstant: -5)
            .done()
        
        emailTextView
            .constrainWidth(to: safeBounds.widthAnchor, multiplier: 0.7)
            .alignCenterX(to: safeBounds.centerXAnchor)
            .anchorTop(to: chatLabel.bottomAnchor, withConstant: 40)
            .done()
        
        passwordTextView
            .constrainWidth(to: emailTextView.widthAnchor)
            .alignCenterX(to: safeBounds.centerXAnchor)
            .anchorTop(to: emailTextView.bottomAnchor, withConstant: 20)
            .done()
        
        loginButton
            .constrainWidth(to: passwordTextView.widthAnchor)
            .alignCenterX(to: safeBounds.centerXAnchor)
            .anchorTop(to: passwordTextView.bottomAnchor, withConstant: 20)
            .done()
        
        view.setNeedsUpdateConstraints()
    }
}
