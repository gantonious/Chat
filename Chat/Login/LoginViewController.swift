//
//  LoginViewController.swift
//  Chat
//
//  Created by George Antonious on 2018-05-30.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
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
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        buildViews()
    }
    
    private func buildViews() {
        let safeBounds = view.safeAreaLayoutGuide
        
        //view.backgroundColor = .red
        view.addSubview(emailTextView)
        view.addSubview(passwordTextView)
        view.addSubview(loginButton)
        
        emailTextView
            .constrainWidth(to: safeBounds.widthAnchor, multiplier: 0.7)
            .alignCenterX(to: safeBounds.centerXAnchor)
            .anchorTop(to: safeBounds.topAnchor, withConstant: 275)
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
