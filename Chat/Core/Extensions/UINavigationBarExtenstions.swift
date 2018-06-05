//
//  UINavigationBarExtenstions.swift
//  Chat
//
//  Created by George Antonious on 2018-06-03.
//  Copyright © 2018 George Antonious. All rights reserved.
//

import UIKit

extension UINavigationBar {
    var titleTextColor: UIColor? {
        set {
            self.titleTextAttributes = [NSAttributedStringKey.foregroundColor:newValue as Any]
        }
        get {
            return titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor
        }
    }
}
