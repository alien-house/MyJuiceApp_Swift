//
//  UIColor.swift
//  MyJuice_Swift
//
//  Created by sin on 2017/05/13.
//  Copyright © 2017年 shinji. All rights reserved.
//

import UIKit
import Foundation

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha:1)
    }
}
