//
//  UIView+constraints.swift
//  OrdersApp
//
//  Created by George Antonious on 2018-05-06.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import UIKit

protocol Anchorable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

extension UIView: Anchorable { }
extension UILayoutGuide: Anchorable { }

extension UIView {
    var horizontalHuggingPriority: UILayoutPriority {
        get {
            return self.contentHuggingPriority(for: .horizontal)
        }
        set {
            self.setContentHuggingPriority(newValue, for: .horizontal)
        }
    }
    
    var verticalHuggingPriority: UILayoutPriority {
        get {
            return self.contentHuggingPriority(for: .vertical)
        }
        set {
            self.setContentHuggingPriority(newValue, for: .vertical)
        }
    }
    
    func fill(inside anchor: Anchorable, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return self.anchorTop(to: anchor.topAnchor, withConstant: c)
            .anchorBottom(to: anchor.bottomAnchor, withConstant: -1 * c)
            .anchorLeading(to: anchor.leadingAnchor, withConstant: c)
            .anchorTrailing(to: anchor.trailingAnchor, withConstant: c)
    }
    
    func fillWidth(inside anchor: Anchorable, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return self.anchorLeading(to: anchor.leadingAnchor, withConstant: c)
            .anchorTrailing(to: anchor.trailingAnchor, withConstant: -1 * c)
    }
    
    func fillHeight(inside anchor: Anchorable, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        return self.anchorTop(to: anchor.topAnchor, withConstant: c)
            .anchorBottom(to: anchor.bottomAnchor, withConstant: -1 * c)
    }
    
    func anchorLeading(to anchor: NSLayoutXAxisAnchor, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    
    func anchorTrailing(to anchor: NSLayoutXAxisAnchor, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.trailingAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    
    func anchorLeft(to anchor: NSLayoutXAxisAnchor, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    
    func anchorRight(to anchor: NSLayoutXAxisAnchor, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    
    func anchorTop(to anchor: NSLayoutYAxisAnchor, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    
    func anchorBottom(to anchor: NSLayoutYAxisAnchor, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    
    func constrainWidth(to dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: dimension, multiplier: m).isActive = true
        return self
    }
    
    func constrainHeight(to dimension: NSLayoutDimension, multiplier m: CGFloat = 1) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalTo: dimension, multiplier: m).isActive = true
        return self
    }
    
    func with(height: CGFloat) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }
    
    func with(width: CGFloat) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }
    
    func alignCenterX(to anchor: NSLayoutXAxisAnchor, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    
    func alignCenterY(to anchor: NSLayoutYAxisAnchor, withConstant c: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: anchor, constant: c).isActive = true
        return self
    }
    
    func done() {
        return
    }
}
