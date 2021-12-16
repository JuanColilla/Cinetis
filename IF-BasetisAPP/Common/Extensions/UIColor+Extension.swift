//
//  UIColor+Extension.swift
//  IF-BasetisAPP
//
//  Created by Nekane Pardo on 13/10/2021.
//  Copyright © 2021 Basetis. All rights reserved.
//

import Foundation

import UIKit.UIColor

extension UIColor {
    
    class func accentColor() -> UIColor {
        return UIColor(named:"AccentColor") ?? UIColor.systemPurple
    }
}
